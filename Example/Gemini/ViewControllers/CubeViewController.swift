import UIKit
import Gemini

final class CubeViewController: UIViewController {
    @IBOutlet private weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.isPagingEnabled = true

            if #available(iOS 11.0, *) {
                collectionView.contentInsetAdjustmentBehavior = .never
            }

            collectionView.gemini
                .cubeAnimation()
                .shadowEffect(.fadeIn)
        }
    }

    private let cellIdentifier = String(describing: PlayerCollectionViewCell.self)
    private var direction: UICollectionView.ScrollDirection = .horizontal
    private var movieURLs = Resource.movie.urls

    static func make(scrollDirection: UICollectionView.ScrollDirection) -> CubeViewController {
        let storyboard = UIStoryboard(name: "CubeViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CubeViewController") as! CubeViewController
        viewController.direction = scrollDirection
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
            collectionView.collectionViewLayout = layout
        }

        navigationController?.setNavigationBarHidden(true, animated: false)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:)))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }

    @objc private func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension CubeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()

        collectionView.visibleCells
            .compactMap { $0 as? PlayerCollectionViewCell }
            .forEach { $0.playerView.pause() }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        (collectionView.visibleCells.first as? PlayerCollectionViewCell)?.playerView.play()
    }
}

// MARK: - UICollectionViewDataSource

extension CubeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PlayerCollectionViewCell
        cell.configure(with: movieURLs[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CubeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
