//
//  GeminiCollectionView.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

public final class GeminiCollectionView: UICollectionView {
    public let gemini: Gemini = GeminiAnimationModel()

    private var animationModel: GeminiAnimationModel? {
        return gemini as? GeminiAnimationModel
    }

    override public var collectionViewLayout: UICollectionViewLayout {
        didSet {
            updateScrollDirection(with: collectionViewLayout)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateScrollDirection(with: collectionViewLayout)
    }

    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        updateScrollDirection(with: layout)
    }

    override public func setCollectionViewLayout(_ layout: UICollectionViewLayout, animated: Bool) {
        super.setCollectionViewLayout(layout, animated: animated)
        updateScrollDirection(with: layout)
    }

    override public func setCollectionViewLayout(_ layout: UICollectionViewLayout, animated: Bool, completion: ((Bool) -> Swift.Void)? = nil) {
        super.setCollectionViewLayout(layout, animated: animated, completion: completion)
        updateScrollDirection(with: layout)
    }

    /// Call this method in `scrollViewDidScroll(_:)`.
    public func animateVisibleCells() {
        guard let model = animationModel, model.isEnabled else { return }

        visibleCells
            .compactMap { $0 as? GeminiCell }
            .forEach(animateCell)
    }

    /// Call this method `collectionView(_:cellForItemAt:)` and `collectionView(_:willDisplay:forItemAt:)`.
    public func animateCell(_ cell: GeminiCell) {
        guard let model = animationModel, model.isEnabled else { return }

        let convertedFrame = convert(cell.frame, to: superview)
        let distance = model.distanceFromCenter(withParentFrame: frame, cellFrame: convertedFrame)

        if model.needsCheckDistance &&
            abs(distance) >= model.visibleMaxDistance(withParentFrame: frame, cellFrame: convertedFrame) {
            return
        }

        let ratio = model.distanceRatio(withParentFrame: frame, cellFrame: convertedFrame)
        let easingRatio = model.easing.value(withRatio: ratio)

        // Configure cell appearance properties
        cell.shadowView?.alpha  = model.shadowAlpha(withDistanceRatio: easingRatio)
        if let alpha = model.alpha(withDistanceRatio: easingRatio) {
            cell.alpha = alpha
        }
        if let cornerRadius = model.cornerRadius(withDistanceRatio: easingRatio) {
            cell.layer.cornerRadius = cornerRadius
        }
        if let backgroundColor = model.backgroundColor(withDistanceRatio: easingRatio) {
            cell.backgroundColor = backgroundColor
        }

        // Configure transform of CALayer
        // Needs set anchor point before setting transform
        cell.adjustAnchorPoint(model.anchorPoint(withDistanceRatio: easingRatio))
        cell.layer.transform = model.transform(withParentFrame: frame, cellFrame: convertedFrame)
    }

    private func updateScrollDirection(with layout: UICollectionViewLayout) {
        (layout as? UICollectionViewFlowLayout).map { animationModel?.scrollDirection = $0.scrollDirection }
    }
}
