//
//  ConstraintArray.swift
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

extension Array where Element: NSLayoutConstraint {
    public func activate() -> [Element] {
        NSLayoutConstraint.activateConstraints(self)
        return self
    }

    public func deactivate() -> [Element] {
        NSLayoutConstraint.deactivateConstraints(self)
        return self
    }
}
