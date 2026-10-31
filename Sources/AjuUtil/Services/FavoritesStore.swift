import Foundation
import SwiftToolkit

@MainActor
public final class FavoritesStore: ObservableObject {
    @Published public private(set) var ids: Set<String> = []

    private let key = "aju_util_favorites"
    private let defaults = TypedUserDefaults()

    public init() {
        if let saved: [String] = defaults.value(forKey: key) {
            ids = Set(saved)
        }
    }

    public func contains(_ id: String) -> Bool {
        ids.contains(id)
    }

    public func toggle(_ id: String) {
        if ids.contains(id) {
            ids.remove(id)
        } else {
            ids.insert(id)
        }
        _ = defaults.set(Array(ids), forKey: key)
    }
}
