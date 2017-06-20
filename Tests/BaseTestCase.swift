//
//  BaseTestCase.swift
//  Tests
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

import XCTest
import Bamboo

#if os(iOS) || os(tvOS)
    public let LayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh
#elseif os(macOS)
    public let LayoutPriorityDefaultHigh = NSLayoutPriorityDefaultHigh
#endif

class BaseTestCase: XCTestCase {
    let value: CGFloat = 3

    let superview = View()
    let view1 = View()
    let view2 = View()
    let view3 = View()

    var subviews: [View] { return [view1, view2, view3] }

    override func setUp() {
        super.setUp()

        superview.addSubview(view1)
        superview.addSubview(view2)
        superview.addSubview(view3)
    }

    override func tearDown() {
        super.tearDown()

        superview.removeConstraints(superview.constraints)
        view1.removeConstraints(view1.constraints)
        view2.removeConstraints(view2.constraints)
        view3.removeConstraints(view3.constraints)
    }

    func betweenConstraints(_ attribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        return [NSLayoutConstraint(item: view1, attribute: attribute, toItem: view2),
                NSLayoutConstraint(item: view2, attribute: attribute, toItem: view3)]
    }
}
