//
//  PlayerCollectionViewCell.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/07/02.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import Gemini

final class PlayerCollectionViewCell: GeminiCell {
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var blackShadowView: UIView!

    override var shadowView: UIView? {
        return blackShadowView
    }

    func configure(with url: URL) {
        playerView.setVideoURL(url)
        playerView.play()
    }
}
