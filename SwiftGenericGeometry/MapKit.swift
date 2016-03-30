//
//  MapKit.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

import MapKit

extension MKMapPoint: Equatable {
}

public func == (lhs: MKMapPoint, rhs: MKMapPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

extension MKMapPoint: PointType {
}

extension MKMapPoint: CustomStringConvertible {
    public var description: String {
        return "\(x), \(y)"
    }
}

// MARK: -

extension MKMapSize: Equatable {
}

public func == (lhs: MKMapSize, rhs: MKMapSize) -> Bool {
    return lhs.width == rhs.width && lhs.height == rhs.height
}

extension MKMapSize: SizeType {
}

extension MKMapSize: CustomStringConvertible {
    public var description: String {
        return "\(width), \(height)"
    }
}

// MARK: -

extension MKMapRect: Equatable {
}

public func == (lhs: MKMapRect, rhs: MKMapRect) -> Bool {
    return lhs.origin == rhs.origin && lhs.size == rhs.size
}

extension MKMapRect: RectType {
}

// MARK: -


public struct MapPolygon: PolygonType {
    public let points: [CGPoint]

    public init(points: [CGPoint]) {
        self.points = points
    }
}


public struct MapLineSegment: LineSegmentType {
    public let first: CGPoint
    public let second: CGPoint

    public init(first: CGPoint, second: CGPoint) {
        self.first = first
        self.second = second
    }
}

public func == (lhs: MapLineSegment, rhs: MapLineSegment) -> Bool {
    return lhs.first == rhs.first && lhs.second == rhs.second
}

//public extension MapLineSegment {
//    func transform(transform: CGAffineTransform) -> MapLineSegment {
//        return LineSegment(first: start * transform, second: end * transform)
//    }
//}





