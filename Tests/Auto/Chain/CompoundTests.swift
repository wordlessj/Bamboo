//
//  CompoundTests.swift
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

class CompoundTests: BaseTestCase {
    func testCenter() {
        let constraints = view1.constrain.center().constraints
        let testConstraints = [NSLayoutConstraint(item: view1, attribute: .centerX, toItem: superview),
                               NSLayoutConstraint(item: view1, attribute: .centerY, toItem: superview)]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testSize() {
        let constraints = view1.constrain.size().constraints
        let testConstraints = [NSLayoutConstraint(item: view1, attribute: .width, toItem: superview),
                               NSLayoutConstraint(item: view1, attribute: .height, toItem: superview)]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testSizeWithCGSize() {
        let size = CGSize(width: 2, height: 3)
        let constraints = view1.constrain.size(size).constraints
        let testConstraints = [NSLayoutConstraint(item: view1, dimension: .width, constant: size.width),
                               NSLayoutConstraint(item: view1, dimension: .height, constant: size.height)]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testSizeWithValues() {
        let width: CGFloat = 2
        let height: CGFloat = 3
        let constraints = view1.constrain.size(width: width, height: height).constraints
        let testConstraints = [NSLayoutConstraint(item: view1, dimension: .width, constant: width),
                               NSLayoutConstraint(item: view1, dimension: .height, constant: height)]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testChains() {
        let constraints = view1.constrain.center().size().constraints
        let testConstraints = [NSLayoutConstraint(item: view1, attribute: .centerX, toItem: superview),
                               NSLayoutConstraint(item: view1, attribute: .centerY, toItem: superview),
                               NSLayoutConstraint(item: view1, attribute: .width, toItem: superview),
                               NSLayoutConstraint(item: view1, attribute: .height, toItem: superview)]
        XCTAssertEqual(constraints, testConstraints)
    }
}
