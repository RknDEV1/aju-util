import Foundation

public struct UtilityItem: Codable, Identifiable, Hashable {
    public let id: String
    public let title: String
    public let category: UtilityCategory
    public let summary: String
    public let phone: String?
    public let url: String?
    public let tags: [String]

    public init(
        id: String,
        title: String,
        category: UtilityCategory,
        summary: String,
        phone: String? = nil,
        url: String? = nil,
        tags: [String] = []
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.summary = summary
        self.phone = phone
        self.url = url
        self.tags = tags
    }
}

public enum UtilityCategory: String, Codable, CaseIterable, Identifiable {
    case emergency
    case government
    case health
    case education
    case city
    case tech

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .emergency: return "Emergência"
        case .government: return "Serviços públicos"
        case .health: return "Saúde"
        case .education: return "Educação"
        case .city: return "Cidade e orla"
        case .tech: return "Tech e inovação"
        }
    }

    public var systemImage: String {
        switch self {
        case .emergency: return "cross.case.fill"
        case .government: return "building.columns.fill"
        case .health: return "heart.fill"
        case .education: return "graduationcap.fill"
        case .city: return "mappin.and.ellipse"
        case .tech: return "laptopcomputer"
        }
    }
}
