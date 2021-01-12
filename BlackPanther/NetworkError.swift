//
//  NetworkError.swift
//  BlackPanther
//
//  Created by James Furlong on 12/1/21.
//

import Foundation

public enum NetworkError: Error {
    case badUrl
    case invalidData
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .badUrl: return NSLocalizedString("Bad Url", comment: "The url supplied is not in the correct format")
            case .invalidData: return NSLocalizedString("Invalid Data", comment: "The data received is invalid")
        }
    }
}
