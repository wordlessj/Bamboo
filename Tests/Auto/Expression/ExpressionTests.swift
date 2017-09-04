//
//  ExpressionTests.swift
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

class ExpressionTests: XCTestCase {
    private let view = View()
    private let value: CGFloat = 3

    func testInt() {
        let constant = 3
        let p: ConstantParameter = parameter(constant)
        XCTAssertEqual(p.constant, CGFloat(constant))
    }

    func testDouble() {
        let constant = 3.0
        let p: ConstantParameter = parameter(constant)
        XCTAssertEqual(p.constant, CGFloat(constant))
    }

    func testCGFloat() {
        let p: ConstantParameter = parameter(value)
        XCTAssertEqual(p.constant, value)
    }

    func testView() {
        let p: BasicParameter = parameter(view)
        XCTAssertEqual(p.item, view)
    }

    #if os(iOS) || os(tvOS)
    func testLayoutGuide() {
        let guide = UILayoutGuide()
        let p: BasicParameter = parameter(guide)
        XCTAssertEqual(p.item, guide)
    }
    #endif

    func testLayoutXAxisAnchor() {
        let anchor = NSLayoutXAxisAnchor()
        let p: BasicParameter = parameter(anchor)
        XCTAssertEqual(p.item, anchor)
    }

    func testLayoutYAxisAnchor() {
        let anchor = NSLayoutYAxisAnchor()
        let p: BasicParameter = parameter(anchor)
        XCTAssertEqual(p.item, anchor)
    }

    func testLayoutDimension() {
        let anchor = NSLayoutDimension()
        let p: BasicParameter = parameter(anchor)
        XCTAssertEqual(p.item, anchor)
    }

    func testPlus() {
        let p: ConstantParameter = parameter(view + value)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.constant, value)
    }

    func testReversedPlus() {
        let p: ConstantParameter = parameter(value + view)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.constant, value)
    }

    func testMinus() {
        let p: ConstantParameter = parameter(view - value)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.constant, -value)
    }

    func testMultiply() {
        let p: MultiplierParameter = parameter(value * view)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.multiplier, value)
    }

    func testReversedMultiply() {
        let p: MultiplierParameter = parameter(view * value)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.multiplier, value)
    }

    func testDivide() {
        let p: MultiplierParameter = parameter(view / value)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.multiplier, 1 / value)
    }

    func testGreaterThanOrEqual() {
        let p: BasicParameter = parameter(>=view)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.relation, .greaterThanOrEqual)
    }

    func testLessThanOrEqual() {
        let p: BasicParameter = parameter(<=view)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.relation, .lessThanOrEqual)
    }

    func testPriority() {
        let priority = LayoutPriority.defaultHigh
        let p: BasicParameter = parameter(view ~ priority)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.priority, priority)
    }

    func testPriorityValue() {
        let priority: Float = 800
        let p: BasicParameter = parameter(view ~ priority)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.priority.rawValue, priority)
    }

    func testFull() {
        let multiplier: CGFloat = 2
        let priority = LayoutPriority.defaultHigh
        let p: FullParameter = parameter(>=view * multiplier + value ~ priority)
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.multiplier, multiplier)
        XCTAssertEqual(p.constant, value)
        XCTAssertEqual(p.relation, .greaterThanOrEqual)
        XCTAssertEqual(p.priority, priority)
    }

    #if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    func testSystemSpacing() {
        let multiplier: CGFloat = 2
        let p: SystemSpacingParameter = parameter(view + SystemSpacing(multiplier))
        XCTAssertEqual(p.item, view)
        XCTAssertEqual(p.multiplier, multiplier)
    }
    #endif

    private func parameter<Expression: ParameterExpression>(_ expression: Expression) -> Expression.Parameter {
        return expression.bb_parameter
    }
}
