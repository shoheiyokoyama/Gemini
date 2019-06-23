import UIKit
import AVFoundation

final class PlayerView: UIView {
    private var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    private var player: AVPlayer? {
        return playerLayer.player
    }

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
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
