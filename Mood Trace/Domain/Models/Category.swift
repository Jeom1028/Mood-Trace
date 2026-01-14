import UIKit

enum Category: String, CaseIterable, Codable {
    case coffee, meal, shopping, transport, gift, etc

    var title: String {
        switch self {
        case .coffee: return "커피"
        case .meal: return "식사"
        case .shopping: return "쇼핑"
        case .transport: return "교통"
        case .gift: return "선물"
        case .etc: return "기타"
        }
    }

    var emoji: String {
        switch self {
        case .coffee: return "☕️"
        case .meal: return "🍚"
        case .shopping: return "🛍️"
        case .transport: return "🚌"
        case .gift: return "🎁"
        case .etc: return "🧾"
        }
    }
}

