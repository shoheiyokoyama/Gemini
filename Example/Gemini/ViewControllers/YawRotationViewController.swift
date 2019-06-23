import UIKit
import Gemini

final class YawRotationViewController: UIViewController {
    @IBOutlet private weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor(red: 255 / 255, green: 212 / 255, blue: 100 / 255, alpha: 1)

            if #available(iOS 11.0, *) {
                collectionView.contentInsetAdjustmentBehavior = .never
            }

            collectionView.gemini
                .yawRotationAnimation()
                .scale(0.7)
                .yawEffect(rotationEffect)
        }
    }

    private let cellIdentifier = String(describing: ImageCollectionViewCell.self)
    private var rotationEffect = YawRotationEffect.yawUp
    private var scrollDirection = UICollectionView.ScrollDirection.horizontal
    private let images = Resource.image.images

    static func make(scrollDirection: UICollectionView.ScrollDirection, effect: YawRotationEffect) -> YawRotationViewController {
        let storyboard = UIStoryboard(name: "YawRotationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "YawRotationViewController") as! YawRotationViewController
        viewController.rotationEffect  = effect
        viewController.scrollDirection = scrollDirection
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
        layout.itemSize = CGSize(width: view.bounds.width - 50, height: view.bounds.width - 50)
        let cellHeight: CGFloat = view.bounds.width - 50
        layout.sectionInset = UIEdgeInsets(top: (view.bounds.height - cellHeight) / 2, left: 25, bottom: (view.bounds.height - cellHeight) / 2, right: 25)
        layout.minimumLineSpacing = 80
        layout.minimumInteritemSpacing = 80
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }

    @objc private func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension YawRotationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

// MARK: - UICollectionViewDelegate

extension YawRotationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension YawRotationViewController: UICollectionViewDataSource {
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
