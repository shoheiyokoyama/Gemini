//
//  CubeViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/19.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class CubeViewController: UIViewController {

    @IBOutlet weak var collectionView: GeminiCollectionView! {
        didSet {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.delegate   = self
            collectionView.dataSource = self
            collectionView.isPagingEnabled = true
            collectionView.gemini
                .cubeAnimation()
                .shadowEffect(.fadeIn)
        }
    }
    fileprivate let cellIdentifier = "PlayerCollectionViewCell"

    var direction: UICollectionViewScrollDirection = .horizontal

    fileprivate var movieURLs: [URL] = Resource.movie.urls

    static func make(scrollDirection: UICollectionViewScrollDirection) -> CubeViewController {
        let storyboard = UIStoryboard(name: "CubeViewController", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CubeViewController") as! CubeViewController
        viewController.direction = scrollDirection
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting of UICollectionViewFlowLayout
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = direction
            collectionView.collectionViewLayout = layout
        }

        // Switch navigation bar hidden
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBarHidden(_:))))
    }

    func toggleNavigationBarHidden(_ gestureRecognizer: UITapGestureRecognizer) {
        let isNavigationBarHidden = navigationController?.isNavigationBarHidden ?? true
        navigationController?.setNavigationBarHidden(!isNavigationBarHidden, animated: true)
    }
}

// MARK: - UIScrollViewDelegate
extension CubeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()

        // Pause movie during scrolling
        collectionView.visibleCells
            .flatMap { $0 as? PlayerCollectionViewCell }
            .forEach { cell in
                cell.playerView.pause()
            }
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
