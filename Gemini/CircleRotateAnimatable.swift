public enum CircleRotationDirection {
    /// Item rotate in clockwise direction.
    case clockwise

    /// Item rotate in anticlockwise direction.
    case anticlockwise
}

public protocol CircleRotationAnimatable: ScaleAnimatable, UIAppearanceAnimatable {
    /// The radius of the circle. The default value is 100.
    @discardableResult func radius(_ radius: CGFloat) -> CircleRotationAnimatable

    /// The direction of rotation. The default value is `CircleRotationDirection.clockwise`.
    @discardableResult func rotateDirection(_ direction: CircleRotationDirection) -> CircleRotationAnimatable

    /// A Boolean value indicating whether the item rotates or not.
    @discardableResult func itemRotationEnabled(_ isEnabled: Bool) -> CircleRotationAnimatable
}

extension GeminiAnimationModel: CircleRotationAnimatable {
    @discardableResult
    public func radius(_ radius: CGFloat) -> CircleRotationAnimatable {
        circleRadius = radius
        return self
    }

    @discardableResult
    public func rotateDirection(_ direction: CircleRotationDirection) -> CircleRotationAnimatable {
        rotateDirection = direction
        return self
    }

    @discardableResult
    public func itemRotationEnabled(_ isEnabled: Bool) -> CircleRotationAnimatable {
        isItemRotationEnabled = isEnabled
        return self
    }
}
