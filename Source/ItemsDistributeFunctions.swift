//
//  ItemsDistributeFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ConstraintItemsChain {
    @discardableResult
    public func distributeHorizontally(spacing: CGFloat = 0) -> ConstraintItemsMany<Item> {
        return between { $1.constrain.after($0, spacing: spacing) }
    }

    @discardableResult
    public func distributeVertically(spacing: CGFloat = 0) -> ConstraintItemsMany<Item> {
        return between { $1.constrain.below($0, spacing: spacing) }
    }
}
