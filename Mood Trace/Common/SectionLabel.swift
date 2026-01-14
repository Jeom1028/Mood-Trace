import UIKit

final class SectionLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = .systemFont(ofSize: 15, weight: .semibold)
        self.textColor = .secondaryLabel
    }
    required init?(coder: NSCoder) { fatalError() }
}
