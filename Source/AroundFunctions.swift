//
//  AroundFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ConstraintChain {
    @discardableResult
    public func before(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> NextChain {
        let p = parameter(item) { $0.leftAnchor }
        return right(p - spacing)
    }

    @discardableResult
    public func after(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> NextChain {
        let p = parameter(item) { $0.rightAnchor }
        return left(p + spacing)
    }

    @discardableResult
    public func above(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> NextChain {
        let p = parameter(item) { $0.topAnchor }
        return bottom(p - spacing)
    }

    @discardableResult
    public func below(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> NextChain {
        let p = parameter(item) { $0.bottomAnchor }
        return top(p + spacing)
    }

    private func parameter<Anchor>(
        _ parameterItem: ConstraintItem?,
        anchorOf: (ConstraintItem) -> Anchor
    ) -> BasicParameter<Anchor> {
        return BasicParameter(item: anchorOf(parameterItem ?? item.superview!))
    }
}
