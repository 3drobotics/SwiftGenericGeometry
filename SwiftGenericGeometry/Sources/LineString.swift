//
//  LineString.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

// TODO: Rename to Polyline?
public protocol LineStringType {
    associatedtype Point: PointType

    var points: [Point] { get }

    init(points: [Point])
}

public extension LineStringType where Point.Scalar: FloatingPoint {
    func boundingBox <Rect: RectType> () -> Rect where Rect.Point.Scalar: FloatingPoint, Rect.Point.Scalar == Rect.Size.Scalar, Point == Rect.Point {
        return points.boundingBox()
    }
}

public extension LineStringType {

    init <LineSegment: LineSegmentType> (segments: [LineSegment]) where LineSegment.Point == Point {
        let points = segments.flatMap() {
            return [ $0.first, $0.second ]
        }
        self.init(points: points)
    }

    func toLineSegments <LineSegment: LineSegmentType>() -> [LineSegment] where LineSegment.Point == Point {
        precondition(points.count >= 2)
        return stride(from: 0, to: points.count - 1, by: 1)
            .map() { Array(points[$0 ..< $0 + 2]) }
            .map() { ($0[0], $0[1]) }
            .map() { LineSegment(first: $0, second: $1) }
    }
}

public extension LineStringType where Point.Scalar: FloatingPoint {

    func intersections <LineSegment: LineSegmentType> (_ segment: LineSegment) -> [Point] where LineSegment.Point == Point {
        let segments: [LineSegment] = toLineSegments()
        return segments.compactMap() {
            return $0.intersection(segment)
        }
    }

}
