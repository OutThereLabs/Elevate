//
//  Encoder.swift
//  Elevate
//
//  Created by Julian Tescher on 7/6/16.
//  Copyright © 2016 Nike. All rights reserved.
//

import Foundation

public protocol Encoder {
    associatedtype EncodeeType

    /**
     Encodes the given object into a value of type `Data`.

     - parameter object: The object to encode.
     - returns: The encoded object.
     
     Note: Return must be a valid JSONSerialization type:
     - The top level object is an NSArray or NSDictionary.
     - All objects are instances of NSString, NSNumber, NSArray, NSDictionary, or NSNull.
     - All dictionary keys are instances of NSString.
     - Numbers are not NaN or infinity.
     */
    func encodeObject(_ object: EncodeeType) -> Any
}

public class DateEncoder: Encoder {
    public typealias EncodeeType = Date

    private let formatter: Formatter

    public init(dateFormatString: String) {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = dateFormatString
        self.formatter = dateFormatter
    }

    public init(dateFormatter: DateFormatter) {
        self.formatter = dateFormatter
    }

    @available(OSX 10.12, *)
    @available(iOS 10.0, *)
    public init(dateFormatter: ISO8601DateFormatter) {
        self.formatter = dateFormatter
    }

    @available(OSX 10.12, *)
    @available(iOS 10.0, *)
    public init() {
        self.formatter = ISO8601DateFormatter()
    }

    public func encodeObject(_ date: Date) -> Any {
        return formatter.string(for: date)!
    }
}
