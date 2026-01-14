import UIKit

final class MoodButton: UIButton {

    let mood: Mood

    init(mood: Mood) {
        self.mood = mood
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func configure() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = mood.toneColor
        config.baseForegroundColor = .label
        config.cornerStyle = .large
        config.titleAlignment = .center
        config.titlePadding = 4

        config.attributedTitle = AttributedString("\(mood.emoji)\n\(mood.title)", attributes: AttributeContainer([
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        ]))

        // 줄바꿈 대응: titleLabel 세팅
        titleLabel?.numberOfLines = 2
        titleLabel?.textAlignment = .center

        self.configuration = config
        layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
    }

    func setSelected(_ isSelected: Bool) {
        if isSelected {
            layer.borderColor = UIColor.label.withAlphaComponent(0.25).cgColor
            layer.borderWidth = 2
            transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        } else {
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 1
            transform = .identity
        }
    }
}
