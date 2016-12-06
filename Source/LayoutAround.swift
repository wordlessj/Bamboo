//
//  LayoutAround.swift
//  Bamboo
//
//  Created by Javier on 12/6/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension LayoutChain {
    @discardableResult
    public func before(_ item: LayoutItem, spacing: CGFloat = 0) -> LayoutChain {
        return right(item.left - spacing)
    }

    @discardableResult
    public func after(_ item: LayoutItem, spacing: CGFloat = 0) -> LayoutChain {
        return left(item.right + spacing)
    }

    @discardableResult
    public func above(_ item: LayoutItem, spacing: CGFloat = 0) -> LayoutChain {
        return bottom(item.top - spacing)
    }

    @discardableResult
    public func below(_ item: LayoutItem, spacing: CGFloat = 0) -> LayoutChain {
        return top(item.bottom + spacing)
    }
}
