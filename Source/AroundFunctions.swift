//
//  AroundFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

extension ConstraintChain {
    @discardableResult
    public func before(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> ConstraintOne<Item> {
        let parameter = ConstraintParameter(item: item, attribute: .left)
        return right(parameter - spacing)
    }

    @discardableResult
    public func after(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> ConstraintOne<Item> {
        let parameter = ConstraintParameter(item: item, attribute: .right)
        return left(parameter + spacing)
    }

    @discardableResult
    public func above(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> ConstraintOne<Item> {
        let parameter = ConstraintParameter(item: item, attribute: .top)
        return bottom(parameter - spacing)
    }

    @discardableResult
    public func below(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> ConstraintOne<Item> {
        let parameter = ConstraintParameter(item: item, attribute: .bottom)
        return top(parameter + spacing)
    }
}
