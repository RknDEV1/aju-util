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
                    PrimaryButton("Ligar \(displayPhone(phone))") {
                        call(phone)
                    }
                }

                if let urlString = item.url,
                   let url = URL(string: urlString) {
                    SecondaryButton("Abrir site") {
                        openURL(url)
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

                Text("Em emergência grave, priorize 190 / 192 / 193 / 199.")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .padding()
        }
        .navigationTitle(item.title)
    }

    private func displayPhone(_ phone: String) -> String {
        if phone.hasPrefix("0800") || phone.count <= 4 {
            return phone
        }
        if phone.hasPrefix("79") && phone.count >= 10 {
            let ddd = String(phone.prefix(2))
            let rest = String(phone.dropFirst(2))
            return "(\(ddd)) \(rest)"
        }
        return phone
    }

    private func call(_ phone: String) {
        let cleaned = phone.filter { $0.isNumber }
        guard let url = URL(string: "tel://\(cleaned)") else { return }
        openURL(url)
    }

    private func openURL(_ url: URL) {
        #if canImport(UIKit)
        UIApplication.shared.open(url)
        #endif
    }
}
