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
