//
//  Types.swift
//  Bamboo
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
    public typealias View = UIView
    public typealias EdgeInsets = UIEdgeInsets
#else
    import AppKit
    public typealias View = NSView
    public typealias EdgeInsets = NSEdgeInsets
#endif
