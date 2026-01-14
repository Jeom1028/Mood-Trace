import UIKit
import SnapKit

final class RecordEditorViewController: UIViewController {

    // MARK: - Output
    var onSave: ((Record) -> Void)?

    // MARK: - State
    private var selectedMood: Mood? = nil
    private var selectedCategory: Category = .coffee

    // MARK: - UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "오늘의 흔적"
        l.font = .boldSystemFont(ofSize: 28)
        return l
    }()

    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "기분을 선택하고, 한 줄로 남겨주세요."
        l.font = .systemFont(ofSize: 15)
        l.textColor = .secondaryLabel
        return l
    }()

    private let moodSectionLabel = SectionLabel(text: "기분")
    private lazy var moodGrid = MoodGridView { [weak self] mood in
        self?.selectedMood = mood
        self?.updateSaveButtonState()
    }

    private let categorySectionLabel = SectionLabel(text: "카테고리")
    private lazy var categoryControl: UISegmentedControl = {
        let items = Category.allCases.map { "\($0.emoji) \($0.title)" }
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = Category.allCases.firstIndex(of: .coffee) ?? 0
        sc.addTarget(self, action: #selector(didChangeCategory), for: .valueChanged)
        return sc
    }()

    private let amountSectionLabel = SectionLabel(text: "금액 (선택)")
    private let amountField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "예: 4500"
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        return tf
    }()

    private let reasonSectionLabel = SectionLabel(text: "왜 소비했나요?")
    private let reasonField: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.systemGray5.cgColor
        tv.layer.cornerRadius = 12
        tv.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        tv.heightAnchor.constraint(equalToConstant: 140).isActive = true
        return tv
    }()

    private let hintLabel: UILabel = {
        let l = UILabel()
        l.text = "한 줄이면 충분해요. (예: 피곤해서 습관처럼)"
        l.font = .systemFont(ofSize: 13)
        l.textColor = .tertiaryLabel
        return l
    }()

    private let saveButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "저장"
        config.baseBackgroundColor = .systemGray3
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        let b = UIButton(configuration: config)
        b.isEnabled = false
        return b
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        navigationItem.title = "기록하기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(didTapClose))

        setupLayout()

        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        updateSaveButtonState()
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            Spacer(height: 12),

            moodSectionLabel,
            moodGrid,
            Spacer(height: 18),

            categorySectionLabel,
            categoryControl,
            Spacer(height: 18),

            amountSectionLabel,
            amountField,
            Spacer(height: 18),

            reasonSectionLabel,
            reasonField,
            hintLabel,
            Spacer(height: 22),

            saveButton,
            Spacer(height: 24)
        ])
        stack.axis = .vertical
        stack.spacing = 10

        contentView.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        saveButton.snp.makeConstraints { $0.height.equalTo(52) }
    }

    private func updateSaveButtonState() {
        let hasMood = selectedMood != nil
        let hasReason = !reasonField.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        let enabled = hasMood && hasReason
        saveButton.isEnabled = enabled

        if enabled {
            saveButton.configuration?.baseBackgroundColor = .label
        } else {
            saveButton.configuration?.baseBackgroundColor = .systemGray3
        }
    }

    @objc private func didChangeCategory() {
        let idx = categoryControl.selectedSegmentIndex
        selectedCategory = Category.allCases[max(0, min(idx, Category.allCases.count - 1))]
    }

    @objc private func didTapClose() {
        dismiss(animated: true)
    }

    @objc private func didTapSave() {
        guard let mood = selectedMood else { return }

        let amount = Int(amountField.text ?? "")
        let reason = reasonField.text.trimmingCharacters(in: .whitespacesAndNewlines)

        let record = Record(
            id: UUID(),
            date: Date(),
            amount: amount,
            category: selectedCategory,
            reason: reason,
            mood: mood
        )

        onSave?(record)
        dismiss(animated: true)
    }
}

// MARK: - UITextView change tracking
extension RecordEditorViewController: UITextViewDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reasonField.delegate = self
    }

    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
}
