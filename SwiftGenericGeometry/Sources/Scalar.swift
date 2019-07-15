//
//  Scalar.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol ScalarType: Comparable, SignedNumeric {
    static func + (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self

    init(_ value: Int)
    init(_ value: Double)
}

extension Int: ScalarType {
}

extension Float: ScalarType {
}

extension Double: ScalarType {
}

