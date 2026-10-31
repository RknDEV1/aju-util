import Foundation

public enum DataService {

    public static func loadItems() -> [UtilityItem] {
        guard let url = Bundle.module.url(forResource: "items", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let items = try? JSONDecoder().decode([UtilityItem].self, from: data) else {
            return Self.fallbackItems
        }
        return items
    }

    public static func search(_ query: String, in items: [UtilityItem]) -> [UtilityItem] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return items }

        return items.filter { item in
            item.title.lowercased().contains(q)
                || item.summary.lowercased().contains(q)
                || item.tags.contains { $0.lowercased().contains(q) }
                || item.category.title.lowercased().contains(q)
        }
    }

    /// Minimal offline set if JSON fails to load.
    private static let fallbackItems: [UtilityItem] = [
        UtilityItem(
            id: "samu",
            title: "SAMU",
            category: .emergency,
            summary: "Urgências e emergências médicas",
            phone: "192",
            tags: ["emergência", "saúde", "ambulância"]
        ),
        UtilityItem(
            id: "bombeiros",
            title: "Bombeiros",
            category: .emergency,
            summary: "Incêndio, salvamento e emergências",
            phone: "193",
            tags: ["emergência", "fogo"]
        ),
        UtilityItem(
            id: "policia",
            title: "Polícia Militar",
            category: .emergency,
            summary: "Ocorrências policiais",
            phone: "190",
            tags: ["emergência", "segurança"]
        ),
    ]
}
