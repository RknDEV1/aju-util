import SwiftUI
import MapKit

struct PlaceMapView: View {
    let item: UtilityItem

    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        Group {
            if let lat = item.latitude, let lon = item.longitude {
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
                .navigationTitle(item.title)
            } else {
                ContentUnavailablePlaceholder(
                    title: "Sem mapa",
                    systemImage: "map",
                    description: "Este item ainda não tem coordenadas."
                )
                .navigationTitle(item.title)
            }
        }
    }
}
