//
//  SDKError.swift
//  DocumentReaderSDK
//
//  Created by Safe City Mac 001 on 17/11/2021.
//

import Foundation

// MARK: - Custom API Based Error

enum APIError: Error {
    case unexpected(code: Int)
    case serviceUnAvailable
    case authenticationError
    case invalidAPI
    case invalidAPIResponse
    case badRequest
    case convertionError
}
extension APIError {
    var isFatal: Bool {
        if case APIError.unexpected = self { return true }
        else { return false }
    }
}

extension APIError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .unexpected(_):
                return "An unexpected error occurred."
            case .serviceUnAvailable:
                return "Service UnAvailable"
            case .authenticationError:
                return "Session Expired"
            case .invalidAPI:
                return "Invalid API Call"
            case .invalidAPIResponse:
                return "Invalid API Response"
            case .badRequest:
                return "Bad Request"
            case .convertionError:
                return "Cannot Convert Data to Object"
        }
    }
}
