//
//  FillFunctions.swift
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

extension ConstraintChain {
    @discardableResult
    public func fill(_ item: ConstraintItem? = nil,
                     insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(nil, of: item, insets: insets)
    }

    @discardableResult
    public func fillLeft(_ item: ConstraintItem? = nil,
                         insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(.left, of: item, insets: insets)
    }

    @discardableResult
    public func fillRight(_ item: ConstraintItem? = nil,
                          insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(.right, of: item, insets: insets)
    }

    @discardableResult
    public func fillTop(_ item: ConstraintItem? = nil,
                        insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(.top, of: item, insets: insets)
    }

    @discardableResult
    public func fillBottom(_ item: ConstraintItem? = nil,
                           insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(.bottom, of: item, insets: insets)
    }

    @discardableResult
    public func fillLeading(_ item: ConstraintItem? = nil,
                            insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(.leading, of: item, insets: insets)
    }

    @discardableResult
    public func fillTrailing(_ item: ConstraintItem? = nil,
                             insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(.trailing, of: item, insets: insets)
    }

    @discardableResult
    public func fillWidth(_ item: ConstraintItem? = nil,
                          insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(.width, of: item, insets: insets)
    }

    @discardableResult
    public func fillHeight(_ item: ConstraintItem? = nil,
                           insets: EdgeInsets = EdgeInsets()) -> ConstraintMany<Item> {
        return fill(.height, of: item, insets: insets)
    }

    private func fill(_ attribute: NSLayoutAttribute?,
                      of item: ConstraintItem?,
                      insets: EdgeInsets) -> ConstraintMany<Item> {
        let modify: (inout ConstraintParameter) -> () = { _ in }
        return fill(attribute, of: item, insets: insets,
                    modifyLeft: modify, modifyRight: modify,
                    modifyTop: modify, modifyBottom: modify,
                    modifyLeading: modify, modifyTrailing: modify)
    }

    fileprivate func fill(
        _ attribute: NSLayoutAttribute?,
        of item: ConstraintItem?,
        insets: EdgeInsets,
        modifyLeft: (inout ConstraintParameter) -> (),
        modifyRight: (inout ConstraintParameter) -> (),
        modifyTop: (inout ConstraintParameter) -> (),
        modifyBottom: (inout ConstraintParameter) -> (),
        modifyLeading: (inout ConstraintParameter) -> (),
        modifyTrailing: (inout ConstraintParameter) -> ()
    ) -> ConstraintMany<Item> {
        let hasHorizontal = attribute == nil || attribute == .top || attribute == .bottom || attribute == .width
        let hasVertical = attribute == nil || attribute == .left || attribute == .right ||
            attribute == .leading || attribute == .trailing || attribute == .height

        let parameter = ConstraintParameter(item: item)
        var constraints = [ConstraintOne<Item>]()

        if attribute == .left {
            constraints.append(left(parameter.modified(modifyLeft) + insets.left))
        }
        if attribute == .right {
            constraints.append(right(parameter.modified(modifyRight) - insets.right))
        }
        if attribute == .top || hasVertical {
            constraints.append(top(parameter.modified(modifyTop) + insets.top))
        }
        if attribute == .bottom || hasVertical {
            constraints.append(bottom(parameter.modified(modifyBottom) - insets.bottom))
        }
        if attribute == .leading || hasHorizontal {
            constraints.append(leading(parameter.modified(modifyLeading) + insets.left))
        }
        if attribute == .trailing || hasHorizontal {
            constraints.append(trailing(parameter.modified(modifyTrailing) - insets.right))
        }

        return constraintMany(constraints)
    }
}

#if os(iOS)
    extension ConstraintChain {
        @discardableResult
        public func fillMargins(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(nil, of: item)
        }

        @discardableResult
        public func fillLeftMargin(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(.left, of: item)
        }

        @discardableResult
        public func fillRightMargin(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(.right, of: item)
        }

        @discardableResult
        public func fillTopMargin(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(.top, of: item)
        }

        @discardableResult
        public func fillBottomMargin(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(.bottom, of: item)
        }

        @discardableResult
        public func fillLeadingMargin(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(.leading, of: item)
        }

        @discardableResult
        public func fillTrailingMargin(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(.trailing, of: item)
        }

        @discardableResult
        public func fillWidthWithinMargins(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(.width, of: item)
        }

        @discardableResult
        public func fillHeightWithinMargins(_ item: ConstraintItem? = nil) -> ConstraintMany<Item> {
            return fillMargins(.height, of: item)
        }

        private func fillMargins(_ attribute: NSLayoutAttribute?,
                                 of item: ConstraintItem?) -> ConstraintMany<Item> {
            return fill(attribute, of: item, insets: .zero,
                        modifyLeft: { $0.attribute = .leftMargin },
                        modifyRight: { $0.attribute = .rightMargin },
                        modifyTop: { $0.attribute = .topMargin },
                        modifyBottom: { $0.attribute = .bottomMargin },
                        modifyLeading: { $0.attribute = .leadingMargin },
                        modifyTrailing: { $0.attribute = .trailingMargin })
        }
    }
#endif
