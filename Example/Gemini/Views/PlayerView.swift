//
//  PlayerView.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/07/02.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation

final class PlayerView: UIView {
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        return playerLayer.player
    }

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    }

    func setVideoURL(_ url: URL) {
        let playerItem = AVPlayerItem(asset: AVURLAsset(url: url))
        playerLayer.player = AVPlayer(playerItem: playerItem)
    }

    func play() {
        player?.play()
    }

    func pause() {
        player?.pause()
    }
}
