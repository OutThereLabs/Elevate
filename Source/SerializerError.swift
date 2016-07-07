//
//  SerializerError.swift
//  Elevate
//
//  Created by Julian Tescher on 7/7/16.
//  Copyright © 2016 Nike. All rights reserved.
//

import Foundation

/**
 The error types that can be thrown in Elevate.

 - Validation:      An error that occurs when one or more values fail validation.
 */
public enum SerializerError: ErrorProtocol, CustomStringConvertible, CustomDebugStringConvertible {
    case validation(failureReason: String)

    /// The failure reason String.
    public var failureReason: String {
        switch self {
        case .validation(let failureReason):
            return failureReason
        }
    }

    /// The description of the failure reason.
    public var description: String {
        switch self {
        case .validation(let failureReason):
            return "Serializer Validation Error - \(failureReason)"
        }
    }

    /// The debug description of the failure reason.
    public var debugDescription: String {
        return self.description
    }
}
