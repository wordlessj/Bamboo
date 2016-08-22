//
//  FrameProtocol.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol FrameProtocol: class, EdgeProtocol {
    var bounds: CGRect { get set }
    var center: CGPoint { get set }
}

extension FrameProtocol {
    public var size: CGSize {
        get { return bounds.size }
        set { bounds.size = newValue }
    }

    public var left: CGFloat {
        get { return center.x - size.width / 2 }
        set { center.x = newValue + size.width / 2 }
    }

    public var right: CGFloat {
        get { return center.x + size.width / 2 }
        set { center.x = newValue - size.width / 2 }
    }

    public var top: CGFloat {
        get { return center.y - size.height / 2 }
        set { center.y = newValue + size.height / 2 }
    }

    public var bottom: CGFloat {
        get { return center.y + size.height / 2 }
        set { center.y = newValue - size.height / 2 }
    }

    public func setSize(size: CGSize) -> Self {
        self.size = size
        return self
    }

    public func setWidth(width: CGFloat) -> Self {
        size.width = width
        return self
    }

    public func setHeight(height: CGFloat) -> Self {
        size.height = height
        return self
    }

    public func setCenter(center: CGPoint) -> Self {
        self.center = center
        return self
    }

    public func setCenterX(centerX: CGFloat) -> Self {
        center.x = centerX
        return self
    }

    public func setCenterY(centerY: CGFloat) -> Self {
        center.y = centerY
        return self
    }

    public func matchWidthToHeight(multiplier multiplier: CGFloat = 1, offset: CGFloat = 0) -> Self {
        return setWidth(round(multiplier * size.height) + offset)
    }

    public func matchHeightToWidth(multiplier multiplier: CGFloat = 1, offset: CGFloat = 0) -> Self {
        return setHeight(round(multiplier * size.width) + offset)
    }

    public func axis(axis: LayoutAxis) -> CGFloat {
        switch axis {
        case .left: return left
        case .right: return right
        case .top: return top
        case .bottom: return bottom
        case .centerX: return center.x
        case .centerY: return center.y
        }
    }

    public func setAxis(axis: LayoutAxis, value: CGFloat) -> Self {
        switch axis {
        case .left: left = value
        case .right: right = value
        case .top: top = value
        case .bottom: bottom = value
        case .centerX: center.x = value
        case .centerY: center.y = value
        }
        
        return self
    }
}

#if os(iOS)
    extension UICollectionViewLayoutAttributes: FrameProtocol {}
#endif
