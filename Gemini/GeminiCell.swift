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
