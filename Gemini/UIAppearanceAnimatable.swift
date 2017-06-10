//
//  UIAppearanceAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/07/01.
//
//

public enum ShadowEffect {
    case fadeIn
    case nextFadeIn
    case previousFadeIn
    case fadeOut
    case none
}

public protocol UIAppearanceAnimatable {
    /// The option of `shadowView` in `GeminiCell`. the default value is `ShadowEffect.none`.
    @discardableResult func shadowEffect(_ effect: ShadowEffect) -> Self

    /// The maxmin alpha of `shadowView` in `GeminiCell`. the default value is 1.0.
    @discardableResult func maxShadowAlpha(_ alpha: CGFloat) -> Self

    /// The minimum alpha of `shadowView` in `GeminiCell`. the default value is 0.0.
    @discardableResult func minShadowAlpha(_ alpha: CGFloat) -> Self

    /// The item’s animatable alpha value in the range 0.0 to 1.0. the default value is 1.0.
    @discardableResult func alpha(_ alpha: CGFloat) -> Self

    /// The radius to use when drawing rounded corners. the default value is 0.0.
    @discardableResult func cornerRadius(_ radius: CGFloat) -> Self

    /// The item’s animatable backgroundColor. item’s backgroundColor changes from startColor to endColor.
    @discardableResult func backgroundColor(startColor: UIColor, endColor: UIColor) -> Self
}

extension GeminiAnimationModel: UIAppearanceAnimatable {
    @discardableResult
    public func shadowEffect(_ effect: ShadowEffect) -> Self {
        shadowEffect = effect
        return self
    }

    @discardableResult
    public func minShadowAlpha(_ alpha: CGFloat) -> Self {
        minShadowAlpha = alpha
        return self
    }

    @discardableResult
    public func maxShadowAlpha(_ alpha: CGFloat) -> Self {
        maxShadowAlpha = alpha
        return self
    }

    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }

    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        cornerRadius = radius
        return self
    }

    @discardableResult
    public func backgroundColor(startColor: UIColor, endColor: UIColor) -> Self {
        startBackgroundColor = startColor
        endBackgroundColor = endColor
        return self
    }
}
