//
//  Serializer.swift
//  Elevate
//
//  Created by Julian Tescher on 7/6/16.
//  Copyright © 2016 Nike. All rights reserved.
//

import Foundation

public class Serializer {

    public class func serializeObject<T: Encodable>(object: T) throws -> Data {
        return try serializeJSON(object.json)
    }

    public class func serializeObject<T: Encodable>(object: T, forKey key: String) throws -> Data {
        if key == "" {
            return try serializeJSON(object.json)
        } else {
            return try serializeJSON([key: object.json])
        }
    }

    public class func serializeObject<T, E : Encoder>(object: T, withEncoder encoder: E) throws -> Data where E.EncodeeType == T {
        return try serializeJSON(encoder.encodeObject(object))
    }

    public class func serializeObject<T, E : Encoder>(object: T, withKey key: String, withEncoder encoder: E) throws -> Data where E.EncodeeType == T {
        if key == "" {
            return try serializeObject(object: object, withEncoder: encoder)
        } else {
            return try serializeJSON([key: encoder.encodeObject(object)])
        }
    }

    public class func serializeJSON(_ json: Any) throws -> Data {
        return try JSONSerialization.data(withJSONObject: json, options: [])
    }

}
