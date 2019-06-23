import UIKit
import Gemini

final class PlayerCollectionViewCell: GeminiCell {
    @IBOutlet private(set) weak var playerView: PlayerView!
    @IBOutlet private weak var blackShadowView: UIView!

    override var shadowView: UIView? {
        return blackShadowView
    }

    func configure(with url: URL) {
        playerView.setVideoURL(url)
        playerView.play()
    }
}
