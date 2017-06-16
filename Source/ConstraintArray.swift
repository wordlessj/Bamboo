//
//  ConstraintArray.swift
//  Bamboo
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension Array where Element: NSLayoutConstraint {
    @discardableResult
    public func activate() -> [Element] {
        NSLayoutConstraint.activate(self)
        return self
    }

    @discardableResult
    public func deactivate() -> [Element] {
        NSLayoutConstraint.deactivate(self)
        return self
    }
}
