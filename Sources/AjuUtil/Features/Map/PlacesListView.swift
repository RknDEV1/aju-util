import SwiftUI

struct PlacesListView: View {
    let items: [UtilityItem]
    @ObservedObject var favorites: FavoritesStore

    var body: some View {
        List {
            Section {
                Text("Pontos com coordenadas. Use “Modo offline” no mapa para ver latitude/longitude sem depender da rede.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Section("Locais") {
                ForEach(items) { item in
                    NavigationLink {
                        PlaceMapView(item: item)
                    } label: {
                        ItemRow(item: item)
                    }
                }
            }
        }
        .navigationTitle("Locais no mapa")
    }
}
