//
//  JSON.swift
//  Elevate
//
//  Created by Julian Tescher on 7/6/16.
//  Copyright © 2016 Nike. All rights reserved.
//

import Foundation

public protocol JsValue: AnyObject {
    func toString() -> String
}

extension JsValue {
    public func data() throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: [])
    }
}

public func ==(lhs: JsValue, rhs: JsValue) -> Bool {
    if type(of: lhs) == type(of: rhs) {
        switch type(of: lhs) {
        case is JsNull.Type:
            return true
        case is JsBoolean.Type:
            return (lhs as! JsBoolean).value == (rhs as! JsBoolean).value
        case is JsNumber.Type:
            return (lhs as! JsNumber).value == (rhs as! JsNumber).value
        case is JsString.Type:
            return (lhs as! JsString).value == (rhs as! JsString).value
        case is JsArray.Type:
            let zippedValues = zip((lhs as! JsArray).value, (rhs as! JsArray).value)
            let checks = zippedValues.map({ (lvalue, rvalue) -> Bool in
                return lvalue == rvalue
            })
            return !checks.contains(false)
        case is JsObject.Type:
            let lhMap = (lhs as! JsObject).underlying
            let rhMap = (rhs as! JsObject).underlying

            if Array(lhMap.keys) == Array(rhMap.keys) {
                for (lKey, lValue) in lhMap {
                    if rhMap[lKey]! != lValue {
                        return false
                    }
                }
                return true
            } else {
                return false
            }
        default:
            return false
        }
    } else {
        return false
    }
}

public func !=(lhs: JsValue, rhs: JsValue) -> Bool { return !(lhs == rhs) }

public class JsNull: JsValue {
    public func toString() -> String {
        return "null"
    }
}

public class JsBoolean: JsValue {
    let value: Bool

    public init(_ value: Bool) {
        self.value = value
    }

    public func toString() -> String {
        return value ? "true" : "false"
    }
}

public class JsNumber: JsValue {
    let value: NSNumber

    public init(_ value: NSNumber) {
        self.value = value
    }

    public func toString() -> String {
        return "\(value)"
    }
}

public class JsString: JsValue {
    var value: String = ""

    public init(_ value: String) {
        self.value = value
    }

    public func toString() -> String {
        return "\"\(value)\""
    }
}

public class JsArray: JsValue {
    let value: [JsValue]

    public init(_ value: [JsValue]) {
        self.value = value
    }

    public func toString() -> String {
        let valueStrings = value.map({ (jsValue: JsValue) -> String in
            return jsValue.toString()
        }).joined(separator: ",")
        return "[\(valueStrings)]"
    }
}

public class JsObject: JsValue {
    let underlying: [String: JsValue]

    public init(_ value: [String: JsValue]) {
        self.underlying = value
    }

    public func toString() -> String {
        var jsonString = ""

        for (key, value) in underlying {
            jsonString += "\"\(key)\":\(value.toString()),"
        }

        if jsonString.characters.count != 0 {
            jsonString = String(jsonString.characters.dropLast())
        }


        return "{\(jsonString)}"
    }
}
