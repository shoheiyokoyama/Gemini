import UIKit

open class GeminiCell: UICollectionViewCell {
    override open func prepareForReuse() {
        super.prepareForReuse()

        adjustAnchorPoint()
        layer.transform = CATransform3DIdentity
    }

    open var shadowView: UIView? {
        return nil
    }
}
