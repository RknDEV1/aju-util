import SwiftUI

struct CategoryListView: View {
    let category: UtilityCategory
    let items: [UtilityItem]
    @ObservedObject var favorites: FavoritesStore

    var body: some View {
        List(items) { item in
            NavigationLink {
                DetailView(item: item, favorites: favorites)
            } label: {
                ItemRow(item: item)
            }
        }
        .navigationTitle(category.title)
    }
}
