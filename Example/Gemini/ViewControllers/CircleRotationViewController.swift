//
//  CircleRotationViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/20.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class CircleRotationViewController: UIViewController {

    static func make(scrollDirection: UICollectionViewScrollDirection, rotateDirection: CircleRotationDirection) -> CircleRotationViewController {
        let storyboard = UIStoryboard(name: "CircleRotationViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CircleRotationViewController") as! CircleRotationViewController
        viewController.scrollDirection = scrollDirection
        viewController.rotateDirection = rotateDirection
        return viewController
    }

    fileprivate let cellIdentifier = "ImageCollectionViewCell"

    private(set) var scrollDirection: UICollectionViewScrollDirection = .horizontal
    private(set) var rotateDirection: CircleRotationDirection = .clockwise

    fileprivate let images: [UIImage] = Resource.image.images

    @IBOutlet fileprivate weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor(red: 234 / 255, green: 242 / 255, blue: 248 / 255, alpha: 1)
            collectionView.gemini
                .circleRotationAnimation()
                .radius(450)
                .rotateDirection(rotateDirection)
                .itemRotationEnabled(true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting of UICollectionViewFlowLayout
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDirection
            collectionView.collectionViewLayout = layout
        }

        // Switch navigation bar hidden
        navigationController?.setNavigationBarHidden(true, animated: false)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:)))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }

    @objc func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension CircleRotationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }
}

// MARK: - UICollectionViewDelegate
extension CircleRotationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CircleRotationViewController: UICollectionViewDataSource {
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

// MARK: - UICollectionViewDelegateFlowLayout
extension CircleRotationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 350)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
