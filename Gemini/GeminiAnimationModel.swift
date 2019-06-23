import UIKit

enum GeminiAnimation {
    case cube
    case circleRotation
    case rollRotation
    case pitchRotation
    case yawRotation
    case custom
    case scale
    case none
}

public protocol Gemini {
    /// `isEnabled` is false if `animation` is GeminiAnimation.none
    var isEnabled: Bool { get }

    // GeminiAnimation

    @discardableResult func cubeAnimation() -> CubeAnimatable
    @discardableResult func customAnimation() -> CustomAnimatable
    @discardableResult func circleRotationAnimation() -> CircleRotationAnimatable
    @discardableResult func rollRotationAnimation() -> RollRotationAnimatable
    @discardableResult func pitchRotationAnimation() -> PitchRotationAnimatable
    @discardableResult func yawRotationAnimation() -> YawRotationAnimatable
    @discardableResult func scaleAnimation() -> ScaleAnimatable
}

extension GeminiAnimationModel: Gemini {
    public var isEnabled: Bool {
        return animation != .none
    }

    @discardableResult
    public func cubeAnimation() -> CubeAnimatable {
        animation = .cube
        return self
    }

    @discardableResult
    public func customAnimation() -> CustomAnimatable {
        animation = .custom
        return self
    }

    @discardableResult
    public func circleRotationAnimation() -> CircleRotationAnimatable {
        animation = .circleRotation
        return self
    }

    @discardableResult
    public func rollRotationAnimation() -> RollRotationAnimatable {
        animation = .rollRotation
        return self
    }

    @discardableResult
    public func pitchRotationAnimation() -> PitchRotationAnimatable {
        animation = .pitchRotation
        return self
    }

    @discardableResult
    public func yawRotationAnimation() -> YawRotationAnimatable {
        animation = .yawRotation
        return self
    }

    @discardableResult
    public func scaleAnimation() -> ScaleAnimatable {
        animation = .scale
        return self
    }
}

final class GeminiAnimationModel {
    // Animation types

    var animation: GeminiAnimation = .none

    // EasingAnimatable

    var easing: GeminiEasing = .linear

    // Cube animation properties

    var cubeDegree: CGFloat = 90

    // CircleRotate animation properties

    var circleRadius: CGFloat = 100
    var rotateDirection: CircleRotationDirection = .clockwise
    var isItemRotationEnabled: Bool = true

    // Scale animation properties

    var scale: CGFloat = 1
    var scaleEffect: GeminScaleEffect = .scaleUp

    // Roll rotation animation properties

    var rollDegree: CGFloat = 90
    var rollEffect: RollRotationEffect = .rollUp

    // Pitch rotation animation properties

    var pitchDegree: CGFloat = 90
    var pitchEffect: PitchRotationEffect = .pitchUp

    // Yaw rotation animation properties

    var yawDegree: CGFloat = 90
    var yawEffect: YawRotationEffect = .yawUp

    // CustomAnimatable properties

    lazy var scaleCoordinate = Coordinate()
    lazy var rotationCoordinate = Coordinate()
    lazy var translationCoordinate = Coordinate()
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)

    // UIAppearanceAnimatable properties

    var alpha: CGFloat?
    var cornerRadius: CGFloat?
    var startBackgroundColor: UIColor?
    var endBackgroundColor: UIColor?
    var maxShadowAlpha: CGFloat = 1
    var minShadowAlpha: CGFloat = 0
    var shadowEffect: ShadowEffect = .none

    var scrollDirection: UICollectionView.ScrollDirection = .vertical

    fileprivate lazy var transform3DIdentity: CATransform3D = {
        var identity = CATransform3DIdentity
        identity.m34 = 1 / 1000
        return identity
    }()

    /// For radian calculation in `GeminiAnimation.circleRotation`.
    var needsCheckDistance: Bool {
        return animation == .circleRotation
    }

    func shadowAlpha(withDistanceRatio ratio: CGFloat) -> CGFloat {
        switch shadowEffect {
        case .fadeIn:
            return minShadowAlpha + abs(ratio) * maxShadowAlpha
        case .nextFadeIn:
            return ratio > 0 ? ratio * maxShadowAlpha : 0
        case .previousFadeIn:
            return ratio < 0 ? -ratio * maxShadowAlpha : 0
        case .fadeOut:
            return (1 - abs(ratio)) * maxShadowAlpha + minShadowAlpha
        case .none:
            return 0
        }
    }

    func alpha(withDistanceRatio ratio: CGFloat) -> CGFloat? {
        guard let alpha = alpha else { return nil }
        return (alpha - 1) * abs(ratio) + 1
    }

    func cornerRadius(withDistanceRatio ratio: CGFloat) -> CGFloat? {
        guard let cornerRadius = cornerRadius else { return nil }
        return cornerRadius * abs(ratio)
    }

    func backgroundColor(withDistanceRatio ratio: CGFloat) -> UIColor? {
        let startColorComponents = startBackgroundColor?.cgColor.components ?? []
        let endColorComponents = endBackgroundColor?.cgColor.components ?? []

        guard startColorComponents.count >= 3 && endColorComponents.count >= 3 else {
            return nil
        }

        let components = (0...3).map { index -> CGFloat in
            (endColorComponents[index] - startColorComponents[index]) * abs(ratio) + startColorComponents[index]
        }
        return UIColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
    }

    func transform(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CATransform3D {
        let _ratio = distanceRatio(withParentFrame: parentFrame, cellFrame: cellFrame)
        let ratio  = _ratio < 0 ? max(-1, _ratio) : min(1, _ratio)
        let easingRatio = easing.value(withRatio: ratio)

        switch animation {
        case .cube:
            let toDegree: CGFloat = max(0, min(90, cubeDegree))
            let degree: CGFloat
            switch scrollDirection {
            case .vertical:
                degree = easingRatio * toDegree
                return CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 1, 0, 0)
            case .horizontal:
                degree = easingRatio * -toDegree
                return CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 0, 1, 0)
            }

        case .circleRotation:
            let distance = distanceFromCenter(withParentFrame: parentFrame, cellFrame: cellFrame)
            let middle   = scrollDirection == .vertical ? parentFrame.midY : parentFrame.midX
            let maxCircleRadius = scrollDirection == .vertical ? middle + cellFrame.height / 2 : middle + cellFrame.width / 2
            let radius: CGFloat = max(maxCircleRadius, circleRadius)
            let _radian = asin(distance / radius)
            let radian  = rotateDirection == .clockwise ? -_radian : _radian

            let rotateTransform, translateTransform: CATransform3D
            switch scrollDirection {
            case .vertical:
                let _x = radius * (1 - cos(_radian))
                let x  = rotateDirection == .clockwise ? _x : -_x
                rotateTransform    = CATransform3DRotate(transform3DIdentity, radian, 0, 0, 1)
                translateTransform = CATransform3DTranslate(transform3DIdentity, x, 0, 0)
            case .horizontal:
                let _y = radius * (1 - cos(_radian))
                let y  = rotateDirection == .clockwise ? -_y : _y
                rotateTransform    = CATransform3DRotate(transform3DIdentity, radian, 0, 0, 1)
                translateTransform = CATransform3DTranslate(transform3DIdentity, 0, y, 0)
            }

            let scale = self.calculatedScale(withRatio: easingRatio)
            let scaleTransform = CATransform3DScale(transform3DIdentity, scale, scale, 1)
            let circleTransform = isItemRotationEnabled ? CATransform3DConcat(rotateTransform, translateTransform) : translateTransform
            return CATransform3DConcat(circleTransform, scaleTransform)

        case .rollRotation:
            let toDegree: CGFloat = max(0, min(90, rollDegree))
            let _degree: CGFloat  = easingRatio * toDegree

            let degree: CGFloat
            switch rollEffect {
            case .rollUp :
                degree = _degree
            case .rollDown:
                degree = -_degree
            case .sineWave:
                degree = abs(_degree)
            case .reverseSineWave:
                degree = -abs(_degree)
            }

            let scale = self.calculatedScale(withRatio: easingRatio)
            let scaleTransform   = CATransform3DScale(transform3DIdentity, scale, scale, 1)
            let rotateTransform  = CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 0, 1, 0)
            return CATransform3DConcat(scaleTransform, rotateTransform)

        case .pitchRotation:
            let toDegree: CGFloat = max(0, min(90, pitchDegree))
            let _degree: CGFloat  = easingRatio * toDegree

            let degree: CGFloat
            switch pitchEffect {
            case .pitchUp :
                degree = -_degree
            case .pitchDown:
                degree = _degree
            case .sineWave:
                degree = -abs(_degree)
            case .reverseSineWave:
                degree = abs(_degree)
            }

            let scale = self.calculatedScale(withRatio: easingRatio)
            let scaleTransform   = CATransform3DScale(transform3DIdentity, scale, scale, 1)
            let rotateTransform  = CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 1, 0, 0)
            return CATransform3DConcat(scaleTransform, rotateTransform)

        case .yawRotation:
            let toDegree: CGFloat = max(0, min(90, pitchDegree))
            let _degree: CGFloat  = easingRatio * toDegree

            let degree: CGFloat
            switch yawEffect {
            case .yawUp :
                degree = _degree
            case .yawDown:
                degree = -_degree
            case .sineWave:
                degree = abs(_degree)
            case .reverseSineWave:
                degree = -abs(_degree)
            }

            let scale = self.calculatedScale(withRatio: easingRatio)
            let scaleTransform   = CATransform3DScale(transform3DIdentity, scale, scale, 1)
            let rotateTransform  = CATransform3DRotate(transform3DIdentity, degree * .pi / 180, 0, 0, 1)
            return CATransform3DConcat(scaleTransform, rotateTransform)

        case .scale:
            let scale = self.calculatedScale(withRatio: easingRatio)
            return CATransform3DScale(transform3DIdentity, scale, scale, 1)

        case .custom:
            let scaleX = calculatedScale(ofScale: scaleCoordinate.x, withRatio: easingRatio)
            let scaleY = calculatedScale(ofScale: scaleCoordinate.y, withRatio: easingRatio)
            let scaleZ = calculatedScale(ofScale: scaleCoordinate.z, withRatio: easingRatio)
            let scaleTransform = CATransform3DScale(
                transform3DIdentity,
                scaleCoordinate.x == 1 ? 1 : scaleX,
                scaleCoordinate.y == 1 ? 1 : scaleY,
                scaleCoordinate.z == 1 ? 1 : scaleZ
            )

            let _vectorXDegree: CGFloat = max(0, min(90, rotationCoordinate.x))
            let vectorXDegree: CGFloat  = _vectorXDegree * easingRatio
            let rotationX = CATransform3DRotate(
                transform3DIdentity,
                vectorXDegree * .pi / 180,
                rotationCoordinate.x == 0 ? 0 : 1,
                0,
                0
            )

            let _vectorYDegree: CGFloat = max(0, min(90, rotationCoordinate.y))
            let vectorYDegree: CGFloat = _vectorYDegree * easingRatio
            let rotationY = CATransform3DRotate(
                transform3DIdentity,
                vectorYDegree * .pi / 180,
                0,
                rotationCoordinate.y == 0 ? 0 : 1,
                0
            )

            let _vectorZDegree: CGFloat = max(0, min(90, rotationCoordinate.z))
            let vectorZDegree: CGFloat = _vectorZDegree * easingRatio
            let rotationZ = CATransform3DRotate(
                transform3DIdentity,
                vectorZDegree * .pi / 180,
                0,
                0,
                rotationCoordinate.z == 0 ? 0 : 1
            )

            let concatedRotateTransform = CATransform3DConcat(rotationX, CATransform3DConcat(rotationY, rotationZ))

            let translateX = easingRatio > 0 ? translationCoordinate.x : -translationCoordinate.x
            let translateY = easingRatio > 0 ? translationCoordinate.y : -translationCoordinate.y
            let translateZ = easingRatio > 0 ? translationCoordinate.z : -translationCoordinate.z
            let translateTransform = CATransform3DTranslate(
                transform3DIdentity,
                translateX * easingRatio,
                translateY * easingRatio,
                translateZ * easingRatio
            )

            return CATransform3DConcat(CATransform3DConcat(scaleTransform, concatedRotateTransform), translateTransform)

        case .none:
            return CATransform3DIdentity
        }
    }

    func anchorPoint(withDistanceRatio ratio: CGFloat) -> CGPoint {
        switch animation {
        case .cube:
            switch scrollDirection {
            case .vertical   where ratio > 0:
                return CGPoint(x: 0.5, y: 0)
            case .vertical   where ratio < 0:
                return CGPoint(x: 0.5, y: 1)
            case .horizontal where ratio > 0:
                return CGPoint(x: 0, y: 0.5)
            case .horizontal where ratio < 0:
                return CGPoint(x: 1, y: 0.5)
            default:
                return CGPoint(x: 0.5, y: 0.5)
            }

        case .circleRotation:
            switch (rotateDirection, scrollDirection) {
            case (.clockwise, .horizontal):
                return CGPoint(x: 0.5, y: 0)
            case (.anticlockwise, .horizontal):
                return CGPoint(x: 0.5, y: 1)
            case (.clockwise, .vertical):
                return CGPoint(x: 1, y: 0.5)
            case (.anticlockwise, .vertical):
                return CGPoint(x: 0, y: 0.5)
            }

        case .custom:
            return anchorPoint

        case .rollRotation,
             .pitchRotation,
             .yawRotation,
             .scale,
             .none:
            return CGPoint(x: 0.5, y: 0.5)
        }
    }

    func distanceFromCenter(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        switch scrollDirection {
        case .vertical:   return cellFrame.midY - parentFrame.midY
        case .horizontal: return cellFrame.midX - parentFrame.midX
        }
    }

    func distanceRatio(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        let distance = distanceFromCenter(withParentFrame: parentFrame, cellFrame: cellFrame)
        switch scrollDirection {
        case .vertical:
            return distance / (parentFrame.height / 2 + cellFrame.height / 2)
        case .horizontal:
            return distance / (parentFrame.width / 2 + cellFrame.width / 2)
        }
    }

    func visibleMaxDistance(withParentFrame parentFrame: CGRect, cellFrame: CGRect) -> CGFloat {
        switch scrollDirection {
        case .vertical:
            return parentFrame.midY + cellFrame.height / 2
        case .horizontal:
            return parentFrame.midX + cellFrame.width / 2
        }
    }

    private func calculatedScale(withRatio ratio: CGFloat) -> CGFloat {
        return calculatedScale(ofScale: scale, withRatio: ratio)
    }

    private func calculatedScale(ofScale scale: CGFloat, withRatio ratio: CGFloat) -> CGFloat {
        let scale: CGFloat = min(max(scale, 0), 1)
        switch scaleEffect {
        case .scaleUp:
            return 1 - (1 - scale) * abs(ratio)
        case .scaleDown:
            return scale + (1 - scale) * abs(ratio)
        }
    }
}


