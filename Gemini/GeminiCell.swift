//
//  GeminiCell.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/10.
//
//

import UIKit

open class GeminiCell: UICollectionViewCell {
    override open func prepareForReuse() {
        super.prepareForReuse()

        // Reset anchorPoint
        adjustAnchorPoint()

        // Reset CATransform3D
        layer.transform = CATransform3DIdentity
    }

    open var shadowView: UIView? {
        return nil
    }
}
