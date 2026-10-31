import SwiftUI

struct FavoritesView: View {
    let items: [UtilityItem]
    @ObservedObject var favorites: FavoritesStore

    private var favoriteItems: [UtilityItem] {
        items.filter { favorites.contains($0.id) }
    }

    var body: some View {
        Group {
            if favoriteItems.isEmpty {
                ContentUnavailablePlaceholder(
                    title: "Nenhum favorito",
                    systemImage: "star",
                    description: "Salve itens na tela de detalhe para vê-los aqui."
                )
            } else {
                List(favoriteItems) { item in
                    NavigationLink {
                        DetailView(item: item, favorites: favorites)
                    } label: {
                        ItemRow(item: item)
                    }
                }
            }
        }
        .navigationTitle("Favoritos")
    }
}

/// Simple empty state without depending on iOS 17-only APIs beyond baseline.
struct ContentUnavailablePlaceholder: View {
    let title: String
    let systemImage: String
    let description: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
            Text(title)
                .font(.title3.weight(.semibold))
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
