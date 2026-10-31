import SwiftUI
import MapKit

struct PlaceMapView: View {
    let item: UtilityItem

    @State private var position: MapCameraPosition = .automatic
    @State private var mapFailed = false

    var body: some View {
        Group {
            if let lat = item.latitude, let lon = item.longitude {
                if mapFailed {
                    OfflinePlaceCard(item: item, latitude: lat, longitude: lon)
                } else {
                    ZStack(alignment: .bottom) {
                        Map(position: $position) {
                            Marker(item.title, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                        }
                        .onAppear {
                            position = .region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                                )
                            )
                        }

                        // Always show offline-capable summary under the map.
                        OfflinePlaceCard(item: item, latitude: lat, longitude: lon, compact: true)
                            .padding()
                    }
                }
            } else {
                ContentUnavailablePlaceholder(
                    title: "Sem coordenadas",
                    systemImage: "map",
                    description: "Este item ainda não tem localização cadastrada."
                )
            }
        }
        .navigationTitle(item.title)
        .toolbar {
            if item.hasCoordinates {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        mapFailed.toggle()
                    } label: {
                        Label(
                            mapFailed ? "Tentar mapa" : "Modo offline",
                            systemImage: mapFailed ? "map" : "wifi.slash"
                        )
                    }
                }
            }
        }
    }
}

/// Works without network: shows coordinates, copy/share and open in Apple Maps when possible.
struct OfflinePlaceCard: View {
    let item: UtilityItem
    let latitude: Double
    let longitude: Double
    var compact: Bool = false

    private var coordinateText: String {
        String(format: "%.5f, %.5f", latitude, longitude)
    }

    private var mapsURL: URL? {
        URL(string: "https://maps.apple.com/?ll=\(latitude),\(longitude)&q=\(item.title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: compact ? 8 : 14) {
            if !compact {
                Image(systemName: "map.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                Text(item.title)
                    .font(.title2.weight(.bold))
                Text(item.summary)
                    .foregroundStyle(.secondary)
            }

            Label("Coordenadas (offline)", systemImage: "mappin.circle")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(coordinateText)
                .font(.body.monospaced())

            Text("O mapa visual precisa de tiles (internet na primeira carga). As coordenadas e o atalho abaixo funcionam offline no aparelho.")
                .font(.caption2)
                .foregroundStyle(.tertiary)

            HStack(spacing: 12) {
                ShareLink(item: "\(item.title)\n\(coordinateText)\nAju Util") {
                    Label("Compartilhar", systemImage: "square.and.arrow.up")
                }

                if let mapsURL {
                    Link(destination: mapsURL) {
                        Label("Apple Maps", systemImage: "arrow.up.right.square")
                    }
                }
            }
            .font(.subheadline.weight(.semibold))
        }
        .padding(compact ? 12 : 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}
