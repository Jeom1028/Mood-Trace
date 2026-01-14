import UIKit
import SnapKit

final class MoodGridView: UIView {

    private let onSelect: (Mood) -> Void
    private var buttons: [MoodButton] = []
    private var selected: Mood?

    init(onSelect: @escaping (Mood) -> Void) {
        self.onSelect = onSelect
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        let grid = UIStackView()
        grid.axis = .vertical
        grid.spacing = 10
        addSubview(grid)
        grid.snp.makeConstraints { $0.edges.equalToSuperview() }

        let moods = Mood.allCases

        // 2 rows × 3 cols
        for row in 0..<2 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 10
            rowStack.distribution = .fillEqually

            for col in 0..<3 {
                let index = row * 3 + col
                let mood = moods[index]
                let b = MoodButton(mood: mood)
                b.addTarget(self, action: #selector(didTapMood(_:)), for: .touchUpInside)
                b.heightAnchor.constraint(equalToConstant: 74).isActive = true
                buttons.append(b)
                rowStack.addArrangedSubview(b)
            }

            grid.addArrangedSubview(rowStack)
        }
    }

    @objc private func didTapMood(_ sender: MoodButton) {
        selected = sender.mood
        buttons.forEach { $0.setSelected($0 === sender) }
        onSelect(sender.mood)
    }
}
