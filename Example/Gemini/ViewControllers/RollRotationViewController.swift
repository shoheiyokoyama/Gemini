import UIKit
import Gemini

final class RollRotationViewController: UIViewController {
    @IBOutlet private weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.backgroundColor = .clear
            collectionView.delegate   = self
            collectionView.dataSource = self

            if #available(iOS 11.0, *) {
                collectionView.contentInsetAdjustmentBehavior = .never
            }

            collectionView.gemini
                .rollRotationAnimation()
                .rollEffect(rotationEffect)
                .scale(0.7)
        }
    }

    private let cellIdentifier = String(describing: ImageCollectionViewCell.self)
    private var rotationEffect = RollRotationEffect.rollUp
    private var scrollDirection = UICollectionView.ScrollDirection.horizontal
    private let images = Resource.image.images

    static func make(scrollDirection: UICollectionView.ScrollDirection, effect: RollRotationEffect) -> RollRotationViewController {
        let storyboard = UIStoryboard(name: "RollRotationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RollRotationViewController") as! RollRotationViewController
        viewController.rotationEffect = effect
        viewController.scrollDirection = scrollDirection
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewPagingFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.itemSize = CGSize(width: view.bounds.width - 60, height: view.bounds.height - 100)
        layout.sectionInset = UIEdgeInsets(top: 50, left: 30, bottom: 50, right: 30)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        navigationController?.setNavigationBarHidden(true, animated: false)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:)))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)

        let startColor = UIColor(red: 29 / 255, green: 44 / 255, blue: 76 / 255, alpha: 1)
        let endColor = UIColor(red: 3 / 255, green: 7 / 255, blue: 20 / 255, alpha: 1)
        let colors: [CGColor] = [startColor.cgColor, endColor.cgColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame.size = view.bounds.size
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc private func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension RollRotationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

// MARK: - UICollectionViewDelegate

extension RollRotationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension RollRotationViewController: UICollectionViewDataSource {
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
