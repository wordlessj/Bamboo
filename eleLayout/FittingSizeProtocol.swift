//
//  FittingSizeProtocol.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol FittingSizeProtocol: FrameProtocol {
    var fittingSize: CGSize { get }
}

extension FittingSizeProtocol {
    @discardableResult
    public func fitSize() -> Self {
        return setSize(fittingSize)
    }

    @discardableResult
    public func fitWidth() -> Self {
        return setWidth(fittingSize.width)
    }

    @discardableResult
    public func fitHeight() -> Self {
        return setHeight(fittingSize.height)
    }
}

#if os(iOS)
    extension UIView: FittingSizeProtocol {
        public var fittingSize: CGSize { return sizeThatFits(superSize) }
    }
#endif
