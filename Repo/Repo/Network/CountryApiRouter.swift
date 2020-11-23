//
//  CountryApiRouter.swift
//  Repo
//
//  Created by Kevin Singh on 16/11/2020.
//

import Foundation
import Alamofire

enum CountryApiRouter {
    case getCountry(code: String)
}

extension CountryApiRouter: URLRequestConvertible {
    
    //    MARK:-  Base URL
    
    var baseUrl: String {
        switch self {
        default:
            return Configuration.URL.CountryApi.base
        }
    }
    
    // MARK: - Method
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - Headers
    
    var headers: [(value: String, headerField: String)] {
        switch self {
        default:
            return []
        }
    }
    
    // MARK: - Parameters
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return [:]
        }
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .getCountry(let country):
            return "/rest/v2/alpha/\(country)"
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .getCountry:
            var queries: [URLQueryItem] = []
            queries.append(URLQueryItem(name: "", value: nil))
            return queries
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URLComponents(string: baseUrl)
        url?.path = path
        if let query = query, !query.isEmpty {
            url?.queryItems = query
        }
        var request = URLRequest(url: (url?.url)!)

        request.httpMethod = method.rawValue
        request.timeoutInterval = 15 * 1_000
        request.cachePolicy = .reloadIgnoringCacheData
        
        // Adding Headers
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.headerField)
        }
        
        switch self {
        default:
            return try URLEncoding.default.encode(request, with: parameters ?? [:])
        }
    }
}
