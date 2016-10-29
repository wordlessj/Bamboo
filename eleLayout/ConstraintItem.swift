//
//  ConstraintItem.swift
//  eleLayout
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

public protocol ConstraintItem: AnyObject {
    var superview: View? { get }
}

extension ConstraintItem {
    public var constrain: ConstraintNone<Self> {
        return ConstraintNone(item: self, allConstraints: [])
    }
}

extension View: ConstraintItem {}

public protocol ItemContainer {
    associatedtype Item: ConstraintItem
    var optionalItem: Item? { get }
}

public struct SuperviewConstrain: ItemContainer {
    public var optionalItem: View? { return nil }
}

public struct Superview {
    public static var constrain: SuperviewConstrain { return SuperviewConstrain() }
}

#if os(iOS)
    @available(iOS 9.0, *)
    extension UILayoutGuide: ConstraintItem {
        public var superview: View? { return owningView }
    }
#endif
