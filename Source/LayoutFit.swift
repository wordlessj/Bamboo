//
//  LayoutFit.swift
//  Bamboo
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol FittingSizeContainer {
    var fittingSize: CGSize { get }
}

#if os(iOS)
    extension UIView: FittingSizeContainer {
        public var fittingSize: CGSize { return sizeThatFits(layout.superSize) }
    }
#endif

extension LayoutChain where Item: FittingSizeContainer {
    @discardableResult
    public func fitSize() -> LayoutChain {
        return size(item.fittingSize)
    }

    @discardableResult
    public func fitWidth() -> LayoutChain {
        return width(item.fittingSize.width)
    }

    @discardableResult
    public func fitHeight() -> LayoutChain {
        return height(item.fittingSize.height)
    }
}
