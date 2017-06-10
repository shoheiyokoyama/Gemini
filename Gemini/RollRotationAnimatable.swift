//
//  RollRotationAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/24.
//
//

public enum RollRotationEffect {
    case rollUp
    case rollDown
    case sineWave
    case reverseSineWave
}

public protocol RollRotationAnimatable: ScaleAnimatable, EasingAnimatable, UIAppearanceAnimatable {
    /// The degree of rotation in the roll direction. the default value is 90.
    /// - seealso: [Pitch, roll, and yaw axes](https://github.com/shoheiyokoyama/Gemini/blob/master/Resources/attitude_rotation.png)
    @discardableResult func degree(_ degree: CGFloat) -> RollRotationAnimatable

    /// The option of `GeminiAnimation.rollRotation`. the default value is `RollRotationEffect.rollUp`.
    @discardableResult func rollEffect(_ effect: RollRotationEffect) -> RollRotationAnimatable
}

extension GeminiAnimationModel: RollRotationAnimatable {
    @discardableResult
    public func degree(_ degree: CGFloat) -> RollRotationAnimatable {
        rollDegree = degree
        return self
    }

    @discardableResult
    public func rollEffect(_ effect: RollRotationEffect) -> RollRotationAnimatable {
        rollEffect = effect
        return self
    }
}
