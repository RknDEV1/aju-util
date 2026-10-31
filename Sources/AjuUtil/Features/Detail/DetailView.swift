import SwiftUI
import SwiftUIKit

struct DetailView: View {
    let item: UtilityItem
    @ObservedObject var favorites: FavoritesStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SectionHeader(item.title, subtitle: item.category.title)

                Text(item.summary)
                    .foregroundStyle(.secondary)

                if let phone = item.phone, !phone.isEmpty {
                    PrimaryButton("Ligar \(phone)") {
                        call(phone)
                    }
                }

                if let urlString = item.url,
                   let url = URL(string: urlString) {
                    SecondaryButton("Abrir site") {
                        #if canImport(UIKit)
                        UIApplication.shared.open(url)
                        #endif
                    }
                }

                Button {
                    favorites.toggle(item.id)
                } label: {
                    Label(
                        favorites.contains(item.id) ? "Remover dos favoritos" : "Salvar nos favoritos",
                        systemImage: favorites.contains(item.id) ? "star.fill" : "star"
                    )
                }

                if !item.tags.isEmpty {
                    Text("Tags: " + item.tags.joined(separator: ", "))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle(item.title)
    }

    private func call(_ phone: String) {
        let cleaned = phone.filter { $0.isNumber }
        guard let url = URL(string: "tel://\(cleaned)") else { return }
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #endif
    }
}
