import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    private let viewModel = HomeViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = HomeLayoutFactory.make()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16)
        cv.dataSource = self
        cv.delegate = self
        cv.register(RecordCardCell.self, forCellWithReuseIdentifier: RecordCardCell.reuseId)
        return cv
    }()

    private let emptyStateView = EmptyStateView()

    private let addButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .label
        config.baseForegroundColor = .systemBackground
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 8
        config.title = "기록"

        let b = UIButton(configuration: config)
        b.layer.shadowOpacity = 0.15
        b.layer.shadowRadius = 10
        b.layer.shadowOffset = CGSize(width: 0, height: 6)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "기분의 흔적"
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        view.addSubview(emptyStateView)
        view.addSubview(addButton)

        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        emptyStateView.snp.makeConstraints { $0.edges.equalToSuperview() }
        addButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)

        // Mock로 UI부터 확인
        viewModel.loadMock()
        refreshUI()
    }

    private func refreshUI() {
        let isEmpty = viewModel.records.isEmpty
        emptyStateView.isHidden = !isEmpty
        collectionView.isHidden = isEmpty
        collectionView.reloadData()
    }

    @objc private func didTapAdd() {
        let editor = RecordEditorViewController()
        editor.onSave = { [weak self] newRecord in
            guard let self else { return }
            self.viewModel.records.insert(newRecord, at: 0) // 최신이 위
            self.refreshUI()
        }

        let nav = UINavigationController(rootViewController: editor)
        nav.modalPresentationStyle = .pageSheet
        present(nav, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.records.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecordCardCell.reuseId,
            for: indexPath
        ) as? RecordCardCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: viewModel.records[indexPath.item])
        return cell
    }
}
