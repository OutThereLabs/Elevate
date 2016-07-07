//
//  Serializer.swift
//  Elevate
//
//  Created by Julian Tescher on 7/6/16.
//  Copyright © 2016 Nike. All rights reserved.
//

import Foundation

public class Serializer {

    public class func serializeObject<T: Encodable>(object: T) -> Data {
        return serializeJSON(object.toJSON())
    }

    public class func serializeObject<T: Encodable>(object: T, forKey key: String) throws -> Data {
        if key == "" {
            return serializeJSON(object.toJSON())
        } else {
            return serializeJSON(JsObject([key: object.toJSON()]))
        }
    }

    public class func serializeObject<T, E : Encoder where E.EncodeeType == T>(object: T, withEncoder encoder: E) -> Data {
        return serializeJSON(encoder.encodeObject(object))
    }

    public class func serializeObject<T, E : Encoder where E.EncodeeType == T>(object: T, withKey key: String, withEncoder encoder: E) -> Data {
        if key == "" {
            return serializeObject(object: object, withEncoder: encoder)
        } else {
            return serializeJSON(JsObject([key: encoder.encodeObject(object)]))
        }
    }

    public class func serializeJSON(_ json: JsValue) -> Data {
        return json.toString().data(using: .utf8)!
    }

}
