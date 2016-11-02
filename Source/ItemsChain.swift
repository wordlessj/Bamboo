//
//  ItemsChain.swift
//  Bamboo
//
//  Created by Javier on 10/7/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

public protocol ConstraintItemsChain {
    associatedtype Item: ConstraintItem
    var items: [Item] { get }
    var allConstraints: [NSLayoutConstraint] { get }
}

public struct ConstraintItemsNone<Item: ConstraintItem>: ConstraintItemsChain {
    public var items: [Item]
    public var allConstraints: [NSLayoutConstraint]
}

public struct ConstraintItemsMany<Item: ConstraintItem>: ConstraintItemsChain {
    public var items: [Item]
    public var constraints: [NSLayoutConstraint]
    public var allConstraints: [NSLayoutConstraint]
}

extension Array where Element: ConstraintItem {
    public var constrain: ConstraintItemsNone<Element> {
        return ConstraintItemsNone(items: self, allConstraints: [])
    }
}
