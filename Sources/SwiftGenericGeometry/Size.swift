//
//  Size.swift
//  SwiftGenericGeometry
//
//  Created by Jonathan Wight on 3/29/16.
//  Copyright © 2016 schwa.io. All rights reserved.
//

public protocol SizeType: Equatable {
    associatedtype Scalar: ScalarType

    var width: Scalar { get set }
    var height: Scalar { get set }

    init()
}

// MARK: -

public extension SizeType {
    static var zero: Self {
        var size = self.init()
        size.height = Scalar(0)
        size.width = Scalar(0)
        return size
    }
}

// MARK: -

public func + <Size: SizeType> (lhs: Size, rhs: Size) -> Size {
    var size = Size.init()
    size.width = lhs.width + rhs.width
    size.height = lhs.height + rhs.height
    return size
}

public func - <Size: SizeType> (lhs: Size, rhs: Size) -> Size {
    var size = Size.init()
    size.width = lhs.width - rhs.width
    size.height = lhs.height - rhs.height
    return size
}

public func * <Size: SizeType> (lhs: Size, rhs: Size) -> Size {
    var size = Size.init()
    size.width = lhs.width * rhs.width
    size.height = lhs.height * rhs.height
    return size
}

public func / <Size: SizeType> (lhs: Size, rhs: Size) -> Size {
    var size = Size.init()
    size.width = lhs.width / rhs.width
    size.height = lhs.height / rhs.height
    return size
}

public func * <Size: SizeType> (lhs: Size, rhs: Size.Scalar) -> Size {
    var size = Size.init()
    size.width = lhs.width * rhs
    size.height = lhs.height * rhs
    return size
}

public func / <Size: SizeType> (lhs: Size, rhs: Size.Scalar) -> Size {
    var size = Size.init()
    size.width = lhs.width / rhs
    size.height = lhs.height / rhs
    return size
}
