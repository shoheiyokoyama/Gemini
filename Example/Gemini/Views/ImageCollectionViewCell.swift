//
//  ImageCollectionViewCell.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/07/02.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class ImageCollectionViewCell: GeminiCell {

    @IBOutlet weak var blackShadowView: UIView!
    @IBOutlet weak var sampleImageView: UIImageView!

    override var shadowView: UIView? {
        return blackShadowView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }

    func configure(with image: UIImage) {
        sampleImageView.image = image
    }
}
