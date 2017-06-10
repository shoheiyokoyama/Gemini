//
//  PitchRotationAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/25.
//
//

public enum PitchRotationEffect {
    case pitchUp
    case pitchDown
    case sineWave
    case reverseSineWave
}

public protocol PitchRotationAnimatable: ScaleAnimatable, EasingAnimatable, UIAppearanceAnimatable {
    /// The degree of rotation in the pitch direction. the default value is 90.
    /// - seealso: [Pitch, roll, and yaw axes](https://github.com/shoheiyokoyama/Gemini/blob/master/Resources/attitude_rotation.png)
    @discardableResult func degree(_ degree: CGFloat) -> PitchRotationAnimatable

    /// The option of `GeminiAnimation.pitchRotation`. the default value is `PitchRotationEffect.pitchUp`.
    @discardableResult func pitchEffect(_ effect: PitchRotationEffect) -> PitchRotationAnimatable
}

extension GeminiAnimationModel: PitchRotationAnimatable {
    @discardableResult
    public func degree(_ degree: CGFloat) -> PitchRotationAnimatable {
        pitchDegree = degree
        return self
    }

    @discardableResult
    public func pitchEffect(_ effect: PitchRotationEffect) -> PitchRotationAnimatable {
        pitchEffect = effect
        return self
    }
}
