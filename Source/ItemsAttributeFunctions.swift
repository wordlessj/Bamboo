//
//  ItemsAttributeFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ItemsConstraintChain {
    @discardableResult
    public func left() -> ItemsChain<Item> {
        return attribute { $0.left($1) }
    }

    @discardableResult
    public func right() -> ItemsChain<Item> {
        return attribute { $0.right($1) }
    }

    @discardableResult
    public func top() -> ItemsChain<Item> {
        return attribute { $0.top($1) }
    }

    @discardableResult
    public func bottom() -> ItemsChain<Item> {
        return attribute { $0.bottom($1) }
    }

    @discardableResult
    public func leading() -> ItemsChain<Item> {
        return attribute { $0.leading($1) }
    }

    @discardableResult
    public func trailing() -> ItemsChain<Item> {
        return attribute { $0.trailing($1) }
    }

    @discardableResult
    public func width() -> ItemsChain<Item> {
        return attribute { $0.width($1) }
    }

    @discardableResult
    public func height() -> ItemsChain<Item> {
        return attribute { $0.height($1) }
    }

    @discardableResult
    public func centerX() -> ItemsChain<Item> {
        return attribute { $0.centerX($1) }
    }

    @discardableResult
    public func centerY() -> ItemsChain<Item> {
        return attribute { $0.centerY($1) }
    }

    @discardableResult
    public func firstBaseline() -> ItemsChain<Item> {
        return attribute { $0.firstBaseline($1) }
    }

    @discardableResult
    public func lastBaseline() -> ItemsChain<Item> {
        return attribute { $0.lastBaseline($1) }
    }

    private func attribute(
        _ closure: (InitialChain<Item>, BasicParameter<Item>) -> InitialChain<Item>.NextChain
    ) -> ItemsChain<Item> {
        return between { closure($0.constrain, BasicParameter(item: $1)) }
    }
}
