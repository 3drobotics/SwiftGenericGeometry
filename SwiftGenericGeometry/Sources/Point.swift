//
//  Point.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol PointType: Equatable {
    associatedtype Scalar: ScalarType

    var x: Scalar { get set }
    var y: Scalar { get set }
    
    init()
}

// MARK: -

public extension PointType {
    static var zero: Self {
        var point = self.init()
        point.x =  Scalar(0)
        point.y =  Scalar(0)
        return point
    }
}

// MARK: -

public prefix func - <Point: PointType> (other: Point) -> Point {
    var point = Point.init()
    point.x =  -other.x
    point.y =  -other.y
    return point
}

// MARK: -

public func + <Point: PointType> (lhs: Point, rhs: Point) -> Point {
    var point = Point.init()
    point.x =  lhs.x + rhs.x
    point.y =  lhs.y + rhs.y
    return point
}

public func - <Point: PointType> (lhs: Point, rhs: Point) -> Point {
    var point = Point.init()
    point.x =  lhs.x - rhs.x
    point.y =  lhs.y - rhs.y
    return point
}

public func * <Point: PointType> (lhs: Point, rhs: Point) -> Point {
    var point = Point.init()
    point.x =  lhs.x * rhs.x
    point.y =  lhs.y * rhs.y
    return point
}

public func / <Point: PointType> (lhs: Point, rhs: Point) -> Point {
    var point = Point.init()
    point.x =  lhs.x / rhs.x
    point.y =  lhs.y / rhs.y
    return point
}

// MARK: -

public func * <Point: PointType> (lhs: Point, rhs: Point.Scalar) -> Point {
    var point = Point.init()
    point.x =  lhs.x * rhs
    point.y =  lhs.y * rhs
    return point
}

public func * <Point: PointType> (lhs: Point.Scalar, rhs: Point) -> Point {
    var point = Point.init()
    point.x =  lhs * rhs.x
    point.y =  lhs * rhs.y
    return point
}

public func / <Point: PointType> (lhs: Point, rhs: Point.Scalar) -> Point {
    var point = Point.init()
    point.x =  lhs.x / rhs
    point.y =  lhs.y / rhs
    return point
}

// MARK: -

public func + <Point: PointType, Size: SizeType> (lhs: Point, rhs: Size) -> Point where Point.Scalar == Size.Scalar {
    var point = Point.init()
    point.x =  lhs.x + rhs.width
    point.y =  lhs.y + rhs.height
    return point
}

public func - <Point: PointType, Size: SizeType> (lhs: Point, rhs: Size) -> Point where Point.Scalar == Size.Scalar {
    var point = Point.init()
    point.x =  lhs.x - rhs.width
    point.y =  lhs.y - rhs.height
    return point
}

// MARK: -

public func min <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point {
    var point = Point.init()
    point.x =  min(lhs.x, rhs.x)
    point.y =  min(lhs.y, rhs.y)
    return point
}

public func max <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point {
    var point = Point.init()
    point.x =  max(lhs.x, rhs.x)
    point.y =  max(lhs.y, rhs.y)
    return point
}

// MARK: -

public func dotProduct <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.x + lhs.y * rhs.y
}

public func crossProduct <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.y - lhs.y * rhs.x
}

// TODO: Rename perpProduct?
public func perp <Point: PointType> (_ lhs: Point, _ rhs: Point) -> Point.Scalar {
    return lhs.x * rhs.y - lhs.y * rhs.x
}

public extension PointType where Scalar: MathType {

    // TODO: Convert to func
    var magnitude: Scalar {
        return sqrt(x * x + y * y)
    }

    func distanceTo(_ other: Self) -> Scalar {
        return (self - other).magnitude
    }

}

