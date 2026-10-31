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

                ShareLink(item: shareText) {
                    Label("Compartilhar", systemImage: "square.and.arrow.up")
                }

                if !item.tags.isEmpty {
                    FlowTags(tags: item.tags)
                }

                Text("Em emergência grave, priorize 190 / 192 / 193 / 199. Dados podem mudar — confira fontes oficiais.")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .padding()
        }
        .navigationTitle(item.title)
    }

    private var shareText: String {
        var parts = ["\(item.title) — Aju Util"]
        parts.append(item.summary)
        if let phone = item.phone {
            parts.append("Tel: \(phone)")
        }
        if let url = item.url {
            parts.append(url)
        }
        return parts.joined(separator: "\n")
    }

    private func displayPhone(_ phone: String) -> String {
        if phone.hasPrefix("0800") || phone.count <= 4 { return phone }
        if phone.hasPrefix("79") && phone.count >= 10 {
            return "(\(phone.prefix(2))) \(phone.dropFirst(2))"
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

struct FlowTags: View {
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tags")
                .font(.caption)
                .foregroundStyle(.secondary)
            FlexibleTagLayout(tags: tags)
        }
    }
}

/// Simple wrapping tags without extra dependencies.
struct FlexibleTagLayout: View {
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 6) {
                    ForEach(row, id: \.self) { tag in
                        Text(tag)
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.secondary.opacity(0.12))
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }

    private var rows: [[String]] {
        var result: [[String]] = [[]]
        for tag in tags {
            if result[result.count - 1].count >= 3 {
                result.append([tag])
            } else {
                result[result.count - 1].append(tag)
            }
        }
        return result
    }
}
