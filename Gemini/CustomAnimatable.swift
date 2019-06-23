extension GeminiAnimationModel {
    struct Coordinate {
        var x: CGFloat = 1
        var y: CGFloat = 1
        var z: CGFloat = 1
    }
}

public protocol CustomAnimatable: EasingAnimatable, UIAppearanceAnimatable {
    /// The Scale in 3-Dimensional vector.
    /// The default value is (x: 1, y: 1, z: 1).
    /// The range 0.0 to 1.0.
    @discardableResult func scale(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> CustomAnimatable

    /// The Angre of rotation in 3-Dimensional vector.
    /// The default value is (x: 0, y: 0, z: 0).
    /// The range 0.0 to 90.0.
    @discardableResult func rotationAngle(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    /// The translation in 3-Dimensional vector.
    /// The default value is (x: 0, y: 0, z: 0).
    @discardableResult func translation(x: CGFloat, y: CGFloat, z: CGFloat) -> CustomAnimatable

    /// The anchor point of the layer's bounds rectangle.
    /// The default value is (x: 0.5, y: 0.5).
    /// - SeeAlso: [anchorPoint on Apple Developer Documentation](https://developer.apple.com/documentation/quartzcore/calayer/1410817-anchorpoint)
    @discardableResult func anchorPoint(_ anchorPoint: CGPoint) -> CustomAnimatable
}

extension GeminiAnimationModel: CustomAnimatable {
    public func scale(x: CGFloat = 1, y: CGFloat = 1, z: CGFloat = 1) -> CustomAnimatable {
        scaleCoordinate.x = x
        scaleCoordinate.y = y
        scaleCoordinate.z = z
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> CustomAnimatable {
        scaleEffect = effect
        return self
    }

    @discardableResult
    public func rotationAngle(x: CGFloat = 1, y: CGFloat = 1, z: CGFloat = 1) -> CustomAnimatable {
        rotationCoordinate.x = x
        rotationCoordinate.y = y
        rotationCoordinate.z = z
        return self
    }

    @discardableResult
    public func translation(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CustomAnimatable {
        translationCoordinate.x = x
        translationCoordinate.y = y
        translationCoordinate.z = z
        return self
    }

    @discardableResult
    public func anchorPoint(_ anchorPoint: CGPoint) -> CustomAnimatable {
        self.anchorPoint = anchorPoint
        return self
    }
}
