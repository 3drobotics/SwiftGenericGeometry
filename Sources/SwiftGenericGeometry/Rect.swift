//
//  Rect.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol RectType: Equatable {
    associatedtype Point: PointType
    associatedtype Size: SizeType

    var origin: Point { get set }
    var size: Size { get set }

    init(origin: Point, size: Size)
}

// MARK: -

public extension RectType {
    var x: Point.Scalar {
        return origin.x
    }

    var y: Point.Scalar {
        return origin.y
    }

    var width: Size.Scalar {
        return size.width
    }

    var height: Size.Scalar {
        return size.height
    }

    init(x: Point.Scalar, y: Point.Scalar, width: Size.Scalar, height: Size.Scalar) {
        var point = Point.init()
        point.x =  x
        point.y =  y
        var size = Size.init()
        size.width = width
        size.height = height
        self.init(origin: point, size: size)
    }

    init(width: Size.Scalar, height: Size.Scalar) {
        var size = Size.init()
        size.width = width
        size.height = height
        self.init(origin: Point.zero, size: size)
    }
}

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar, Size.Scalar: FloatingPoint {
    init(center: Point, size: Size) {
        self.init(origin: center - size * Size.Scalar(0.5), size: size)
    }

    init(center: Point, diameter: Size.Scalar) {
        var size = Size.init()
        size.width = diameter
        size.height = diameter
        self.init(origin: center - size * Size.Scalar(0.5), size: size)
    }

    init(center: Point, radius: Size.Scalar) {
        var size = Size.init()
        size.width = radius * Size.Scalar(2)
        size.height = radius * Size.Scalar(2)
        self.init(origin: center - size * Size.Scalar(0.5), size: size)
    }
}

// MARK: -

public extension RectType {
    static var zero: Self {
        return self.init(origin: Point.zero, size: Size.zero)
    }
}

// MARK: -

public extension RectType where Point.Scalar: FloatingPoint {
    static var null: Self {
        var point = Point.init()
        point.x =  Point.Scalar.infinity
        point.y =  Point.Scalar.infinity
        return self.init(origin: point, size: Size.zero)
    }
    var isNull: Bool {
        var point = Point.init()
        point.x =  Point.Scalar.infinity
        point.y =  Point.Scalar.infinity
        return origin == point
    }
}

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar {

    var minX: Point.Scalar {
        return x
    }

    var minY: Point.Scalar {
        return y
    }

    var maxX: Point.Scalar {
        return x + width
    }

    var maxY: Point.Scalar {
        return y + height
    }

    init(minX: Point.Scalar, minY: Point.Scalar, maxX: Point.Scalar, maxY: Point.Scalar) {
        var point = Point.init()
        point.x =  minX
        point.y =  minY
        var size = Size.init()
        size.width = maxX - minX
        size.height = maxY - minY
        self.init(origin: point, size: size)
    }

    var minXMinY: Point {
        var point = Point.init()
        point.x =  minX
        point.y =  minY
        return point
    }

    var minXMaxY: Point {
        var point = Point.init()
        point.x =  minX
        point.y =  maxY
        return point
    }

    var maxXMinY: Point {
        var point = Point.init()
        point.x =  maxX
        point.y =  minY
        return point
    }

    var maxXMaxY: Point {
        var point = Point.init()
        point.x =  maxX
        point.y =  maxY
        return point
    }
}

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: Comparable {
    init(points: (Point, Point)) {
        let minX = min(points.0.x, points.1.x)
        let minY = min(points.0.y, points.1.y)
        let maxX = max(points.0.x, points.1.x)
        let maxY = max(points.0.y, points.1.y)
        self.init(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }
}

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: FloatingPoint {

    var midX: Point.Scalar {
        return x + width * Point.Scalar(0.5)
    }

    var midY: Point.Scalar {
        return y + height * Point.Scalar(0.5)
    }

    var mid: Point {
        var point = Point.init()
        point.x =  midX
        point.y =  midY
        return point
    }
}

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar {
    func union(_ point: Point) -> Self {
//            let p1 = min(minXminY, point)
//            let p2 = max(maxXmaxY, point)
//            return Self(points: (p1, p2))

        let minX = min(self.minX, point.x)
        let minY = min(self.minY, point.y)
        let maxX = max(self.maxX, point.x)
        let maxY = max(self.maxY, point.y)
        return Self(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }

    func union(_ rect: Self) -> Self {
        let minX = min(self.minX, rect.minX)
        let minY = min(self.minY, rect.minY)
        let maxX = max(self.maxX, rect.maxX)
        let maxY = max(self.maxY, rect.maxY)
        return Self(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }

    func inset(dx: Point.Scalar, dy: Point.Scalar) -> Self {
        return Self(minX: minX + dx, minY: minY + dy, maxX: maxX - dx, maxY: maxY - dy)
    }

    mutating func insetInPlace(dx: Point.Scalar, dy: Point.Scalar) {
        self = Self(minX: minX + dx, minY: minY + dy, maxX: maxX - dx, maxY: maxY - dy)
    }

}

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: FloatingPoint {
    func union(_ point: Point) -> Self {
        if isNull {
            return Self(origin: point, size: Size.zero)
        }
        else {
//            let p1 = min(minXminY, point)
//            let p2 = max(maxXmaxY, point)
//            return Self(points: (p1, p2))

            let minX = min(self.minX, point.x)
            let minY = min(self.minY, point.y)
            let maxX = max(self.maxX, point.x)
            let maxY = max(self.maxY, point.y)
            return Self(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
        }
    }

    func union(_ rect: Self) -> Self {
        if isNull {
            return rect
        }
        else {
            let minX = min(self.minX, rect.minX)
            let minY = min(self.minY, rect.minY)
            let maxX = max(self.maxX, rect.maxX)
            let maxY = max(self.maxY, rect.maxY)
            return Self(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
        }
    }
}

// MARK: -

public extension RectType where Point.Scalar == Size.Scalar, Point.Scalar: Comparable {
    func contains(_ point: Point) -> Bool {
        let xInterval = minX ..< maxX
        let yInterval = minY ..< maxY
        return xInterval.contains(point.x) && yInterval.contains(point.y)
    }
}

// MARK: -

public extension Sequence where Iterator.Element: PointType, Iterator.Element.Scalar: FloatingPoint {
    func boundingBox <Rect: RectType>() -> Rect where Rect.Point == Iterator.Element, Rect.Point.Scalar == Rect.Size.Scalar {
        return reduce(Rect.null) {
            (accumulator, element) in
            return accumulator.union(element)
        }
    }
}



