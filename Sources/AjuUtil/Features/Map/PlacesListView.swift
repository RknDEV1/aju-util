import SwiftUI

struct PlacesListView: View {
    let items: [UtilityItem]
    @ObservedObject var favorites: FavoritesStore

    var body: some View {
        List(items) { item in
            NavigationLink {
                VStack(spacing: 0) {
                    PlaceMapView(item: item)
                        .frame(minHeight: 220)
                    DetailView(item: item, favorites: favorites)
                }
            } label: {
                ItemRow(item: item)
            }
        }
        .navigationTitle("Locais no mapa")
    }
}
