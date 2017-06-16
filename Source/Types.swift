//
//  Types.swift
//  Bamboo
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    public typealias View = UIView
    public typealias LayoutPriority = UILayoutPriority
    public typealias EdgeInsets = UIEdgeInsets
    public let LayoutPriorityRequired = UILayoutPriorityRequired
#else
    public typealias View = NSView
    public typealias LayoutPriority = NSLayoutPriority
    public typealias EdgeInsets = NSEdgeInsets
    public let LayoutPriorityRequired = NSLayoutPriorityRequired
#endif
