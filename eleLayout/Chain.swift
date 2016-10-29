//
//  Chain.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

public protocol ConstraintChain: ItemContainer {
    var item: Item { get }
    var allConstraints: [NSLayoutConstraint] { get }
}

public struct ConstraintNone<Item: ConstraintItem>: ConstraintChain {
    public var item: Item
    public var allConstraints: [NSLayoutConstraint]

    public var optionalItem: Item? { return item }
}

public struct ConstraintOne<Item: ConstraintItem>: ConstraintChain {
    public var item: Item
    public var constraint: NSLayoutConstraint
    public var allConstraints: [NSLayoutConstraint]

    public var optionalItem: Item? { return item }
}

public struct ConstraintMany<Item: ConstraintItem>: ConstraintChain {
    public var item: Item
    public var constraints: [NSLayoutConstraint]
    public var allConstraints: [NSLayoutConstraint]

    public var optionalItem: Item? { return item }
}
