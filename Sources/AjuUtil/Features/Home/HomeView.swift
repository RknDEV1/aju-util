import SwiftUI
import SwiftToolkit
import SwiftUIKit

public struct HomeView: View {
    @StateObject private var favorites = FavoritesStore()
    @State private var query = ""
    @State private var items: [UtilityItem] = []

    public init() {}

    private var filtered: [UtilityItem] {
        DataService.search(query, in: items)
    }

    public var body: some View {
        NavigationStack {
            List {
                Section {
                    ValidatedTextField("Buscar em Aracaju…", text: $query)
                }

                Section("Atalhos") {
                    NavigationLink {
                        FavoritesView(items: items, favorites: favorites)
                    } label: {
                        Label("Favoritos", systemImage: "star.fill")
                    }
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label("Sobre o app", systemImage: "info.circle")
                    }
                }

                Section("Categorias") {
                    ForEach(UtilityCategory.allCases) { category in
                        NavigationLink {
                            CategoryListView(
                                category: category,
                                items: items.filter { $0.category == category },
                                favorites: favorites
                            )
                        } label: {
                            Label(category.title, systemImage: category.systemImage)
                        }
                    }
                }

                Section(query.isBlank ? "Destaques" : "Resultados") {
                    if filtered.isEmpty {
                        Text("Nenhum item encontrado")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(filtered.prefix(query.isBlank ? 8 : 50)) { item in
                            NavigationLink {
                                DetailView(item: item, favorites: favorites)
                            } label: {
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Aju Util")
            .onAppear {
                if items.isEmpty {
                    items = DataService.loadItems()
                }
            }
        }
        .environmentObject(favorites)
    }
}

struct ItemRow: View {
    let item: UtilityItem

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
                .font(.headline)
            Text(item.summary)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 2)
    }
}
