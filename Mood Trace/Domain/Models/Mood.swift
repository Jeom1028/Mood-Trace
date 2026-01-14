import UIKit

enum Mood: String, CaseIterable, Codable {
    case happy, neutral, sad, stressed, calm, excited

    var emoji: String {
        switch self {
        case .happy: return "😊"
        case .neutral: return "😐"
        case .sad: return "😞"
        case .stressed: return "😣"
        case .calm: return "😌"
        case .excited: return "✨"
        }
    }

    var title: String {
        switch self {
        case .happy: return "기분 좋음"
        case .neutral: return "무덤덤"
        case .sad: return "우울"
        case .stressed: return "스트레스"
        case .calm: return "평온"
        case .excited: return "설렘"
        }
    }

    /// 카드 왼쪽 컬러 바에 쓰는 저채도 톤(원하면 나중에 조정)
    var toneColor: UIColor {
        switch self {
        case .happy: return UIColor(hex: "FFF2CC")
        case .neutral: return UIColor(hex: "E5E5E5")
        case .sad: return UIColor(hex: "DDE3EA")
        case .stressed: return UIColor(hex: "E8DDD5")
        case .calm: return UIColor(hex: "E3EFE7")
        case .excited: return UIColor(hex: "FFE8E0")
        }
    }
}
