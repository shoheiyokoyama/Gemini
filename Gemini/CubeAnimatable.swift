//
//  CubeAnimatable.swift
//  Pods
//
//  Created by shoheiyokoyama on 2017/06/12.
//
//

public protocol CubeAnimatable: EasingAnimatable, UIAppearanceAnimatable {

    /// Cube degree for the x-vector in the range 0.0 to 90.0. 
    /// If cubeDegree is 90, it moves like a regular hexahedron. 
    /// The default value is 90.0.
    @discardableResult func cubeDegree(_ degree: CGFloat) -> CubeAnimatable
}

extension GeminiAnimationModel: CubeAnimatable {
    @discardableResult
    public func cubeDegree(_ degree: CGFloat) -> CubeAnimatable {
        cubeDegree = degree
        return self
    }
}
