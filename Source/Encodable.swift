//
//  Encodable.swift
//  Elevate
//
//  Created by Julian Tescher on 7/6/16.
//  Copyright © 2016 Nike. All rights reserved.
//

import Foundation

// MARK: Encodable Protocol Definition

/**
 The `Encodable` protocol declares an interface used to create a JSON object from an object to be serialized.
 */
public protocol Encodable {

    func toJSON() -> JsValue

}

/**
 The primative encodables implemented below are used by the serializer when serializing an array of primative values. 
 */

extension String: Encodable {
    public func toJSON() -> JsValue {
        return JsString(self)
    }
}

extension Int: Encodable {
    public func toJSON() -> JsValue {
        return JsNumber(self)
    }   
}

extension UInt: Encodable {
    public func toJSON() -> JsValue {
        return JsNumber(self)
    }
}

extension Float: Encodable {
    public func toJSON() -> JsValue {
        return JsNumber(self)
    }
}

extension Double: Encodable {
    public func toJSON() -> JsValue {
        return JsNumber(self)
    }
}

extension Bool: Encodable {
    public func toJSON() -> JsValue {
        return JsBoolean(self)
    }
}
