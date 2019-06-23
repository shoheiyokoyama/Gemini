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
