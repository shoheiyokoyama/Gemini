import UIKit
import Gemini

final class ScaleAnimationViewController: UIViewController {
    @IBOutlet private weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self

            if #available(iOS 11.0, *) {
                collectionView.contentInsetAdjustmentBehavior = .never
            }

            collectionView.gemini
                .scaleAnimation()
                .scale(0.75)
                .scaleEffect(scaleEffect)
                .ease(.easeOutQuart)
        }
    }

    private let cellIdentifier = String(describing: ImageCollectionViewCell.self)
    private var scrollDirection = UICollectionView.ScrollDirection.horizontal
    private var scaleEffect = GeminScaleEffect.scaleUp
    private let images = Resource.image.images

    static func make(scrollDirection: UICollectionView.ScrollDirection, scaleEffect: GeminScaleEffect) -> ScaleAnimationViewController {
        let storyboard = UIStoryboard(name: "ScaleAnimationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ScaleAnimationViewController") as! ScaleAnimationViewController
        viewController.scrollDirection = scrollDirection
        viewController.scaleEffect = scaleEffect
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:)))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)

        let layout = UICollectionViewPagingFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.itemSize = CGSize(width: view.bounds.width - 80, height: view.bounds.height - 400)
        layout.sectionInset = UIEdgeInsets(top: 200, left: 40, bottom: 200, right: 40)
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 40
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }

    @objc private func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension ScaleAnimationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

// MARK: - UICollectionViewDelegate

extension ScaleAnimationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ScaleAnimationViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(with: images[indexPath.row])
        self.collectionView.animateCell(cell)
        return cell
    }
}
