//
//  Attributes.swift
//  Bamboo
//
//  Created by Javier on 10/27/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

extension ItemContainer {
    public var left: ConstraintExpression { return expression(.left) }
    public var right: ConstraintExpression { return expression(.right) }
    public var top: ConstraintExpression { return expression(.top) }
    public var bottom: ConstraintExpression { return expression(.bottom) }
    public var leading: ConstraintExpression { return expression(.leading) }
    public var trailing: ConstraintExpression { return expression(.trailing) }
    public var width: ConstraintExpression { return expression(.width) }
    public var height: ConstraintExpression { return expression(.height) }
    public var centerX: ConstraintExpression { return expression(.centerX) }
    public var centerY: ConstraintExpression { return expression(.centerY) }

    public var lastBaseline: ConstraintExpression { return expression(.lastBaseline) }
    public var firstBaseline: ConstraintExpression { return expression(.firstBaseline) }

    fileprivate func expression(_ attribute: NSLayoutAttribute) -> ConstraintExpression {
        return ConstraintParameter(item: optionalItem, attribute: attribute)
    }
}

#if os(iOS)
    extension ItemContainer {
        public var leftMargin: ConstraintExpression { return expression(.leftMargin) }
        public var rightMargin: ConstraintExpression { return expression(.rightMargin) }
        public var topMargin: ConstraintExpression { return expression(.topMargin) }
        public var bottomMargin: ConstraintExpression { return expression(.bottomMargin) }
        public var leadingMargin: ConstraintExpression { return expression(.leadingMargin) }
        public var trailingMargin: ConstraintExpression { return expression(.trailingMargin) }
        public var centerXWithinMargins: ConstraintExpression { return expression(.centerXWithinMargins) }
        public var centerYWithinMargins: ConstraintExpression { return expression(.centerYWithinMargins) }
    }
#endif
