public enum GeminScaleEffect {
    /// `scaleUp` gradually increases frame size of item.
    case scaleUp

    /// `scaleDown` gradually decreases frame size of item.
    case scaleDown
}

public protocol ScaleAnimatable: EasingAnimatable {
    /// The Scale based on 2-Dimensional vector.
    /// The default value is 1.
    /// The range 0.0 to 1.0.
    @discardableResult func scale(_ scale: CGFloat) -> Self

    /// The option of `GeminiAnimation.scale`. the default value is `GeminScaleEffect.scaleUp`.
    @discardableResult func scaleEffect(_ effect: GeminScaleEffect) -> Self
}

extension GeminiAnimationModel: ScaleAnimatable {
    @discardableResult
    public func scale(_ scale: CGFloat) -> Self {
        self.scale = scale
        return self
    }

    @discardableResult
    public func scaleEffect(_ effect: GeminScaleEffect) -> Self {
        scaleEffect = effect
        return self
    }
}
