import Foundation

public enum DataService {

    public static func loadItems() -> [UtilityItem] {
        guard let url = Bundle.module.url(forResource: "items", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let items = try? JSONDecoder().decode([UtilityItem].self, from: data) else {
            return Self.fallbackItems
        }
        return items.sorted { lhs, rhs in
            if lhs.category == rhs.category {
                return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
            }
            return lhs.category.rawValue < rhs.category.rawValue
        }
    }

    public static func search(_ query: String, in items: [UtilityItem]) -> [UtilityItem] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return items }

        return items.filter { item in
            item.title.lowercased().contains(q)
                || item.summary.lowercased().contains(q)
                || (item.phone?.contains(q) ?? false)
                || item.tags.contains { $0.lowercased().contains(q) }
                || item.category.title.lowercased().contains(q)
        }
    }

    private static let fallbackItems: [UtilityItem] = [
        UtilityItem(id: "samu", title: "SAMU", category: .emergency, summary: "Urgências médicas", phone: "192", tags: ["192"]),
        UtilityItem(id: "bombeiros", title: "Bombeiros", category: .emergency, summary: "Incêndio e salvamento", phone: "193", tags: ["193"]),
        UtilityItem(id: "pm", title: "Polícia Militar", category: .emergency, summary: "Ocorrências", phone: "190", tags: ["190"]),
    ]
}
