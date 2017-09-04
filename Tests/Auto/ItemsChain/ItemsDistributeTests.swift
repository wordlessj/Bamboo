//
//  ItemsDistributeTests.swift
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
import Bamboo

class ItemsDistributeTests: BaseTestCase {
    private let inset: CGFloat = 5

    private var distributeXConstraints: [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: view2, attribute: .leading,
                               toItem: view1, toAttribute: .trailing,
                               constant: value),
            NSLayoutConstraint(item: view3, attribute: .leading,
                               toItem: view2, toAttribute: .trailing,
                               constant: value)
        ]
    }

    private var distributeYConstraints: [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: view2, attribute: .top, toItem: view1, toAttribute: .bottom, constant: value),
            NSLayoutConstraint(item: view3, attribute: .top, toItem: view2, toAttribute: .bottom, constant: value)
        ]
    }

    private var insetXConstraints: [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: view1, attribute: .leading, toItem: superview, constant: inset),
            NSLayoutConstraint(item: view3, attribute: .trailing, toItem: superview, constant: -inset)
        ]
    }

    private var insetYConstraints: [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: view1, attribute: .top, toItem: superview, constant: inset),
            NSLayoutConstraint(item: view3, attribute: .bottom, toItem: superview, constant: -inset)
        ]
    }

    func testDistributeX() {
        let constraints = subviews.bb.distributeX(spacing: value).constraints
        XCTAssertEqual(constraints, distributeXConstraints)
    }

    func testDistributeXWithInsetSpacing() {
        let constraints = subviews.bb.distributeX(spacing: value, inset: .fixed(inset)).constraints
        XCTAssertEqual(constraints, distributeXConstraints + insetXConstraints)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func testDistributeXWithEqualInset() {
        let constraints = subviews.bb.distributeX(spacing: value, inset: .equal).constraints
        XCTAssertEqual(constraints.count, 3)
        XCTAssertEqual(Array(constraints[0..<2]), distributeXConstraints)
        XCTAssertNil(constraints[2].firstItem)
    }

    func testDistributeY() {
        let constraints = subviews.bb.distributeY(spacing: value).constraints
        XCTAssertEqual(constraints, distributeYConstraints)
    }

    func testDistributeYWithInsetSpacing() {
        let constraints = subviews.bb.distributeY(spacing: value, inset: .fixed(inset)).constraints
        XCTAssertEqual(constraints, distributeYConstraints + insetYConstraints)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func testDistributeYWithEqualInset() {
        let constraints = subviews.bb.distributeY(spacing: value, inset: .equal).constraints
        XCTAssertEqual(constraints.count, 3)
        XCTAssertEqual(Array(constraints[0..<2]), distributeYConstraints)
        XCTAssertNil(constraints[2].firstItem)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func testDistributeXEqualSpacing() {
        let constraints = subviews.bb.distributeXEqualSpacing().constraints
        XCTAssertEqual(constraints.count, 1)
        XCTAssertNil(constraints[0].firstItem)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func testDistributeXEqualSpacingWithInsetSpacing() {
        let constraints = subviews.bb.distributeXEqualSpacing(inset: .fixed(inset)).constraints
        XCTAssertEqual(constraints.count, 3)
        XCTAssertNil(constraints[0].firstItem)
        XCTAssertEqual(Array(constraints[1..<3]), insetXConstraints)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func testDistributeXEqualSpacingWithEqualInset() {
        let constraints = subviews.bb.distributeXEqualSpacing(inset: .equal).constraints
        XCTAssertEqual(constraints.count, 3)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func testDistributeYEqualSpacing() {
        let constraints = subviews.bb.distributeYEqualSpacing().constraints
        XCTAssertEqual(constraints.count, 1)
        XCTAssertNil(constraints[0].firstItem)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func testDistributeYEqualSpacingWithInsetSpacing() {
        let constraints = subviews.bb.distributeYEqualSpacing(inset: .fixed(inset)).constraints
        XCTAssertEqual(constraints.count, 3)
        XCTAssertNil(constraints[0].firstItem)
        XCTAssertEqual(Array(constraints[1..<3]), insetYConstraints)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    func testDistributeYEqualSpacingWithEqualInset() {
        let constraints = subviews.bb.distributeYEqualSpacing(inset: .equal).constraints
        XCTAssertEqual(constraints.count, 3)
    }
}
