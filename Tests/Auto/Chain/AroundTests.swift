//
//  AroundTests.swift
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

import XCTest

class AroundTests: BaseTestCase {
    func testBefore() {
        let constraint = view1.bb.before(view2, spacing: value).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .trailing,
                                                toItem: view2, toAttribute: .leading,
                                                constant: -value)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testAfter() {
        let constraint = view1.bb.after(view2, spacing: value).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .leading,
                                                toItem: view2, toAttribute: .trailing,
                                                constant: value)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testAbove() {
        let constraint = view1.bb.above(view2, spacing: value).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .bottom,
                                                toItem: view2, toAttribute: .top,
                                                constant: -value)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testBelow() {
        let constraint = view1.bb.below(view2, spacing: value).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .top,
                                                toItem: view2, toAttribute: .bottom,
                                                constant: value)
        XCTAssertEqual(constraint, testConstraint)
    }
}
