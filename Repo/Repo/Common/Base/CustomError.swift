//
//  CustomError.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import Foundation

enum CustomError: Error {
    case noNetwork
    case dataNotFound
    case unknown
    case error(String)
}

extension CustomError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noNetwork:
            return Localizable.errorNoNetwork()
        case .dataNotFound:
            return Localizable.errorDataNotFound()
        case .error(let error):
            return error
        case .unknown:
            return Localizable.errorUnknown()
        }
    }
}
