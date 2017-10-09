//
//  PitchRotationViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/25.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class PitchRotationViewController: UIViewController {

    @IBOutlet fileprivate weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .clear
            collectionView.gemini
                .pitchRotationAnimation()
                .scale(0.7)
                .pitchEffect(rotationEffect)
        }
    }

    fileprivate let cellIdentifier = "ImageCollectionViewCell"
    private(set) var rotationEffect: PitchRotationEffect = .pitchUp
    private(set) var scrollDirection: UICollectionViewScrollDirection = .horizontal

    fileprivate let images: [UIImage] = Resource.image.images

    static func make(scrollDirection: UICollectionViewScrollDirection, effect: PitchRotationEffect) -> PitchRotationViewController {
        let storyboard = UIStoryboard(name: "PitchRotationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PitchRotationViewController") as! PitchRotationViewController
        viewController.rotationEffect  = effect
        viewController.scrollDirection = scrollDirection
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Switch navigation bar hidden
        navigationController?.setNavigationBarHidden(true, animated: false)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:)))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)

        // Setting of UICollectionViewFlowLayout
        let layout = UICollectionViewPagingFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.itemSize = CGSize(width: view.bounds.width - 60, height: view.bounds.height - 100)
        layout.sectionInset = UIEdgeInsets(top: 50, left: 30, bottom: 50, right: 30)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast

        // Setting of BackgroundColor
        let startColor = UIColor(red: 238 / 255, green: 156 / 255, blue: 167 / 255, alpha: 1)
        let endColor = UIColor(red: 225 / 255, green: 221 / 255, blue: 225 / 255, alpha: 1)
        let colors: [CGColor] = [startColor.cgColor, endColor.cgColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame.size = view.frame.size
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @objc func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension PitchRotationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

// MARK: - UICollectionViewDelegate
extension PitchRotationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PitchRotationViewController: UICollectionViewDataSource {
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
