//
//  EncoderTests.swift
//  Elevate
//
//  Created by Julian Tescher on 7/6/16.
//  Copyright © 2016 Nike. All rights reserved.
//

import Elevate
import Foundation
import XCTest

class TestModelWithEncoding: Encodable {
    let name: String

    init(name: String) {
        self.name = name
    }

    func toJSON() -> JsValue {
        return JsObject([
            "name": name.toJSON()
        ])
    }

}

class TestModelWithoutEncoding {
    let name: String

    init(name: String) {
        self.name = name
    }
    
}

class TestModelEncoder: Encoder {
    typealias EncodeeType = TestModelWithoutEncoding

    func encodeObject(_ object: TestModelWithoutEncoding) -> JsValue {
        return JsObject([
            "name": object.name.toJSON()
        ])
    }
}

class SerializerTests: BaseTestCase {

    func testThatItSerializesEncodableObjectsToData() {
        // Given
        let model = TestModelWithEncoding(name: "Test Name")

        // When
        let json = try? Serializer.serializeObject(object: model)

        // Then
        XCTAssertEqual(json, "{\"name\":\"\(model.name)\"}".data(using: .utf8), "Encoded model did not equal json string")
    }

    func testThatItSerializesObjectsWithEncoder() {
        // Given
        let model = TestModelWithoutEncoding(name: "Test Name")
        let encoder = TestModelEncoder()

        // When
        let json = try? Serializer.serializeObject(object: model, withEncoder: encoder)

        // Then
        XCTAssertEqual(json, "{\"name\":\"\(model.name)\"}".data(using: .utf8), "Encoded model with encoder did not equal json value")
    }

}
