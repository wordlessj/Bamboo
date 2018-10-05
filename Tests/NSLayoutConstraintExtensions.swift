//
//  NSLayoutConstraintExtensions.swift
//  Bamboo
//
//  Copyright (c) 2017 Javier Zhang (https://wordlessj.github.io/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Bamboo

extension NSLayoutConstraint {
    convenience init(item: Any, dimension: NSLayoutConstraint.Attribute, constant: CGFloat) {
        self.init(item: item, attribute: dimension, toItem: nil, toAttribute: .notAnAttribute, constant: constant)
    }

    convenience init(item: Any, attribute: NSLayoutConstraint.Attribute,
                     toItem: Any?, toAttribute: NSLayoutConstraint.Attribute? = nil,
                     multiplier: CGFloat = 1, constant: CGFloat = 0,
                     relation: NSLayoutConstraint.Relation = .equal, priority: LayoutPriority = .required) {
        self.init(item: item, attribute: attribute,
                  relatedBy: relation,
                  toItem: toItem, attribute: toAttribute ?? attribute,
                  multiplier: multiplier, constant: constant)
        self.priority = priority
    }

    open override func isEqual(_ object: Any?) -> Bool {
        guard let constraint = object as? NSLayoutConstraint else { return super.isEqual(object) }
        return firstItem as? NSObject == constraint.firstItem as? NSObject &&
            firstAttribute == constraint.firstAttribute &&
            secondItem as? NSObject == constraint.secondItem as? NSObject &&
            secondAttribute == constraint.secondAttribute &&
            multiplier == constraint.multiplier &&
            constant == constraint.constant &&
            relation == constraint.relation &&
            priority == constraint.priority
    }
}
