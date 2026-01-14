import UIKit
import SnapKit

final class RecordCardCell: UICollectionViewCell {
    static let reuseId = "RecordCardCell"

    private let toneBar = UIView()

    private let amountLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 20)
        l.textColor = .label
        return l
    }()

    private let categoryLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.textColor = .secondaryLabel
        return l
    }()

    private let reasonLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        l.textColor = .label
        l.numberOfLines = 2
        return l
    }()

    private let footerLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textColor = .secondaryLabel
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        contentView.backgroundColor = UIColor.secondarySystemBackground
        contentView.layer.cornerRadius = 18
        contentView.layer.masksToBounds = true

        contentView.addSubview(toneBar)
        contentView.addSubview(amountLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(reasonLabel)
        contentView.addSubview(footerLabel)

        toneBar.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(8)
        }

        amountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(toneBar.snp.trailing).offset(14)
            $0.trailing.equalToSuperview().inset(16)
        }

        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(amountLabel.snp.bottom).offset(6)
            $0.leading.equalTo(amountLabel)
            $0.trailing.equalTo(amountLabel)
        }

        reasonLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
            $0.leading.equalTo(amountLabel)
            $0.trailing.equalTo(amountLabel)
        }

        footerLabel.snp.makeConstraints {
            $0.top.equalTo(reasonLabel.snp.bottom).offset(10)
            $0.leading.equalTo(amountLabel)
            $0.trailing.equalTo(amountLabel)
            $0.bottom.equalToSuperview().inset(14)
        }
    }

    func configure(with record: Record) {
        toneBar.backgroundColor = record.mood.toneColor

        if let amount = record.amount {
            amountLabel.text = "₩\(amount.formattedWithSeparator())"
        } else {
            amountLabel.text = "금액 없음"
        }

        categoryLabel.text = "\(record.category.emoji) \(record.category.title)"
        reasonLabel.text = "“\(record.reason)”"

        let dateText = record.date.formatted(date: .abbreviated, time: .omitted)
        footerLabel.text = "\(record.mood.emoji) \(record.mood.title) · \(dateText)"
    }
}
