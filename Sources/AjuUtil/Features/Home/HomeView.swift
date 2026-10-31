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

    private var emergencyItems: [UtilityItem] {
        items.filter { $0.category == .emergency && ["190", "192", "193", "199"].contains($0.phone ?? "") }
    }

    private var mapPlaces: [UtilityItem] {
        items.filter { $0.hasCoordinates }
    }

    private var favoriteItems: [UtilityItem] {
        items.filter { favorites.contains($0.id) }
    }

    public var body: some View {
        NavigationStack {
            List {
                Section {
                    headerCard
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .listRowBackground(Color.clear)

                Section {
                    ValidatedTextField("Buscar em Aracaju…", text: $query)
                }

                if query.isBlank {
                    Section("Emergência rápida") {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(emergencyItems) { item in
                                    EmergencyChip(item: item)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))

                        NavigationLink {
                            EmergencyModeView(items: items)
                        } label: {
                            Label("Abrir modo emergência", systemImage: "sos.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }

                    if !favoriteItems.isEmpty {
                        Section("Seus favoritos") {
                            ForEach(favoriteItems.prefix(5)) { item in
                                NavigationLink {
                                    DetailView(item: item, favorites: favorites)
                                } label: {
                                    ItemRow(item: item)
                                }
                            }
                            if favoriteItems.count > 5 {
                                NavigationLink {
                                    FavoritesView(items: items, favorites: favorites)
                                } label: {
                                    Text("Ver todos (\(favoriteItems.count))")
                                }
                            }
                        }
                    }
                }

                Section("Atalhos") {
                    NavigationLink {
                        FavoritesView(items: items, favorites: favorites)
                    } label: {
                        Label("Favoritos", systemImage: "star.fill")
                    }

                    if !mapPlaces.isEmpty {
                        NavigationLink {
                            PlacesListView(items: mapPlaces, favorites: favorites)
                        } label: {
                            Label("Locais no mapa", systemImage: "map")
                        }
                    }

                    NavigationLink {
                        HealthTipsView()
                    } label: {
                        Label("Dicas de saúde", systemImage: "heart.text.square")
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
                            HStack {
                                Label(category.title, systemImage: category.systemImage)
                                Spacer()
                                Text("\(items.filter { $0.category == category }.count)")
                                    .font(.caption.weight(.semibold))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color.secondary.opacity(0.12))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }

                Section(query.isBlank ? "Destaques" : "Resultados") {
                    if filtered.isEmpty {
                        Text("Nenhum item encontrado")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(filtered.prefix(query.isBlank ? 10 : 80)) { item in
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

    private var headerCard: some View {
        CardView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Aracaju na palma da mão")
                    .font(.title3.weight(.bold))
                Text("Contatos, serviços, dicas de saúde e mapa — com modo offline para coordenadas e listas.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct EmergencyChip: View {
    let item: UtilityItem

    var body: some View {
        Button {
            call(item.phone)
        } label: {
            VStack(spacing: 6) {
                Text(item.phone ?? "—")
                    .font(.title3.weight(.bold))
                Text(shortTitle)
                    .font(.caption2)
                    .lineLimit(1)
            }
            .frame(width: 92, height: 76)
            .background(
                LinearGradient(
                    colors: [Color.red.opacity(0.18), Color.red.opacity(0.08)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .foregroundStyle(.red)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.red.opacity(0.25), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Ligar \(shortTitle) \(item.phone ?? "")")
    }

    private var shortTitle: String {
        switch item.phone {
        case "192": return "SAMU"
        case "193": return "Bombeiros"
        case "190": return "PM"
        case "199": return "Defesa Civil"
        default: return item.title
        }
    }

    private func call(_ phone: String?) {
        guard let phone else { return }
        let cleaned = phone.filter { $0.isNumber }
        guard let url = URL(string: "tel://\(cleaned)") else { return }
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #endif
    }
}

struct ItemRow: View {
    let item: UtilityItem

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.accentColor.opacity(0.12))
                    .frame(width: 36, height: 36)
                Image(systemName: item.category.systemImage)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color.accentColor)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                HStack(spacing: 8) {
                    if let phone = item.phone {
                        Text(phone)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.tint)
                    }
                    if item.hasCoordinates {
                        Label("Mapa", systemImage: "map")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding(.vertical, 2)
    }
}
