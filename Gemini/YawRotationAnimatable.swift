//
//  YawRotationAnimatable.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/26.
//
//

public enum YawRotationEffect {
    case yawUp
    case yawDown
    case sineWave
    case reverseSineWave
}

public protocol YawRotationAnimatable: ScaleAnimatable, UIAppearanceAnimatable {
    /// The degree of rotation in the yaw direction. the default value is 90.0.
    /// - SeeAlso: [Pitch, roll, and yaw axes](https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/attitude_rotation.png)
    @discardableResult func degree(_ degree: CGFloat) -> YawRotationAnimatable

    /// The option of `GeminiAnimation.yawRotation`. the default value is `YawRotationEffect.yawUp`.
    /// `GeminiEasing` is applied to `YawRotationEffect`.
    @discardableResult func yawEffect(_ effect: YawRotationEffect) -> YawRotationAnimatable
}

extension GeminiAnimationModel: YawRotationAnimatable {
    @discardableResult
    public func degree(_ degree: CGFloat) -> YawRotationAnimatable {
        yawDegree = degree
        return self
    }

    @discardableResult
    public func yawEffect(_ effect: YawRotationEffect) -> YawRotationAnimatable {
        yawEffect = effect
        return self
    }
}
