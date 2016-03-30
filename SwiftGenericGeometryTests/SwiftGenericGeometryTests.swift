//
//  SwiftGenericGeometryTests.swift
//  SwiftGenericGeometryTests
//
//  Created by Jonathan Wight on 3/30/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import XCTest

import SwiftGenericGeometry

class SwiftGenericGeometryTests: XCTestCase {
    
    func testSimpleIntRects() {
        let rect = IntRect(x: -100, y: 100, width: 100, height: 200)
        XCTAssert(rect.origin.x == -100)
        XCTAssert(rect.x == -100)
        XCTAssert(rect.minX == -100)
        XCTAssert(rect.origin == IntPoint(x: -100, y: 100))
        XCTAssert(rect.minXMinY == rect.origin)
        XCTAssert(rect.minXMaxY == IntPoint(x: -100, y: 300))
        XCTAssert(rect.maxXMinY == IntPoint(x: 0, y: 100))
        XCTAssert(rect.maxXMaxY == IntPoint(x: 0, y: 300))
        XCTAssert(rect == IntRect(minX: -100, minY: 100, maxX: 0, maxY: 300))
        XCTAssert(IntRect(width: 100, height: 200) == IntRect(minX: 0, minY: 0, maxX: 100, maxY: 200))
    }

    func testCGRectsInits() {
        XCTAssert(CGRect(center: CGPoint(x: 0, y: -100), size: CGSize(width: 100, height: 50)) == CGRect(x: -50, y: -125, width: 100, height: 50))
        XCTAssert(CGRect(center: CGPoint(x: 0, y: -100), diameter: 100) == CGRect(x: -50, y: -150, width: 100, height: 100))
        XCTAssert(CGRect(center: CGPoint(x: 0, y: -100), radius: 50) == CGRect(x: -50, y: -150, width: 100, height: 100))
    }

}