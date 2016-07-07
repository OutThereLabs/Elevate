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
     */
    func encodeObject(_ object: EncodeeType) -> JsValue
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

    public func encodeObject(_ data: Date) -> JsValue {
        return JsString(formatter.string(for: data)!)
    }
}
