import UIKit
import SnapKit

final class EmptyStateView: UIView {

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "아직 흔적이 없어요"
        l.font = .boldSystemFont(ofSize: 22)
        l.textAlignment = .center
        return l
    }()

    private let descLabel: UILabel = {
        let l = UILabel()
        l.text = "오늘의 기분과 소비를\n한 장의 카드로 남겨보세요."
        l.font = .systemFont(ofSize: 16)
        l.textColor = .secondaryLabel
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        addSubview(titleLabel)
        addSubview(descLabel)

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
        }
        descLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) { fatalError() }
}
