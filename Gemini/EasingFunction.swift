//
//  EasingFunction.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/28.
//
//

private typealias EasingParameter = (_ t: CGFloat, _ b: CGFloat, _ c: CGFloat, _ d: CGFloat) -> CGFloat

private struct EasingFunction {
    static let linear: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        return c * t / d + b
    }

    static let easeInQuad: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        let t = t / d
        return c * t * t + b
    }

    static let easeOutQuad: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        let t = t / d
        return -c * t * (t - 2) + b
    }

    static let easeInOutQuad: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / (d / 2)
        if t < 1 {
            return c / 2 * t * t + b
        }
        t -= 1
        return -c / 2 * (t * (t - 2) - 1) + b
    }

    static let easeInCubic: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        let t = t / d
        return c * t * t * t + b
    }

    static let easeOutCubic: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / d
        t -= 1
        return c * (t * t * t + 1) + b
    }

    static let easeInOutCubic: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / (d / 2)
        if t < 1 {
            return c / 2 * t * t * t + b
        }
        t -= 2
        return c / 2 * (t * t * t + 2) + b
    }

    static let easeInQuart: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        let t = t / d
        return c * t * t * t * t + b
    }

    static let easeOutQuart: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / d
        t -= 1
        return -c * ( t * t * t * t - 1) + b
    }

    static let easeInOutQuart: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / (d / 2)
        if t < 1 {
            return c / 2 * t * t * t * t + b
        }
        t -= 2
        return -c / 2 * (t * t * t * t - 2) + b
    }

    static let easeInQuint: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        let t = t / d
        return c * t * t * t * t * t + b
    }

    static let easeOutQuint: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / d
        t -= 1
        return c * (t * t * t * t * t + 1) + b
    }

    static let easeInOutQuint: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / (d / 2)
        if t < 1 {
            return c / 2 * t * t * t * t * t + b
        }
        t -= 2
        return c / 2 * (t * t * t * t * t + 2) + b
    }

    static let easeInSine: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        return -c * cos(t / d * (CGFloat.pi / 2)) + c + b
    }

    static let easeOutSine: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        return c * sin(t / d * (CGFloat.pi / 2)) + b
    }

    static let easeInOutSine: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        return -c / 2 * (cos(CGFloat.pi * t / d) - 1) + b
    }

    static let easeInExpo: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        return c * pow(2, 10 * (t / d - 1) ) + b
    }

    static let easeOutExpo: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        return c * (-pow(2, -10 * t / d) + 1) + b
    }

    static let easeInOutExpo: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / (d / 2)
        if t < 1 {
            return c / 2 * pow(2, 10 * (t - 1)) + b
        }
        t -= 1
        return c/2 * (-pow(2, -10 * t) + 2) + b
    }

    static let easeInCirc: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        let t  = t / d
        return -c * (sqrt(1 - t * t) - 1) + b
    }

    static let easeOutCirc: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / d
        t -= 1
        return c * sqrt(1 - t * t) + b
    }

    static let easeInOutCirc: EasingParameter = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) in
        var t = t / (d / 2)
        if t < 1 {
            return -c / 2 * (sqrt(1 - t * t) - 1) + b
        }
        t -= 2
        return c / 2 * (sqrt(1 - t * t) + 1) + b
    }
}

public enum GeminiEasing {
    case linear
    case easeInQuad
    case easeOutQuad
    case easeInOutQuad
    case easeInCubic
    case easeOutCubic
    case easeInOutCubic
    case easeInQuart
    case easeOutQuart
    case easeInOutQuart
    case easeInQuint
    case easeOutQuint
    case easeInOutQuint
    case easeInSine
    case easeOutSine
    case easeInOutSine
    case easeInExpo
    case easeOutExpo
    case easeInOutExpo
    case easeInCirc
    case easeOutCirc
    case easeInOutCirc
}

extension GeminiEasing {
    func value(withRatio ratio: CGFloat) -> CGFloat {
        let isNegative = ratio < 0
        let result = easingFunction(isNegative ? -ratio : ratio, 0, 1, 1)
        return isNegative ? -result : result
    }

    private var easingFunction: EasingParameter {
        typealias F = EasingFunction

        switch self {
        case .linear:
            return F.linear
        case .easeInQuad:
            return F.easeInQuad
        case .easeOutQuad:
            return F.easeOutQuad
        case .easeInOutQuad:
            return F.easeInOutQuad
        case .easeInCubic:
            return F.easeInCubic
        case .easeOutCubic:
            return F.easeOutCubic
        case .easeInOutCubic:
            return F.easeInOutCubic
        case .easeInQuart:
            return F.easeInQuart
        case .easeOutQuart:
            return F.easeOutQuart
        case .easeInOutQuart:
            return F.easeInOutQuart
        case .easeInQuint:
            return F.easeInQuint
        case .easeOutQuint:
            return F.easeOutQuint
        case .easeInOutQuint:
            return F.easeInOutQuint
        case .easeInSine:
            return F.easeInSine
        case .easeOutSine:
            return F.easeOutSine
        case .easeInOutSine:
            return F.easeInOutSine
        case .easeInExpo:
            return F.easeInExpo
        case .easeOutExpo:
            return F.easeOutExpo
        case .easeInOutExpo:
            return F.easeInOutExpo
        case .easeInCirc:
            return F.easeInCirc
        case .easeOutCirc:
            return F.easeOutCirc
        case .easeInOutCirc:
            return F.easeInOutCirc
        }
    }
}

