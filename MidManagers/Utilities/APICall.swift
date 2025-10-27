//
//  APICall.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 23.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var queryItems: [String: String]? { get }
    var headers: [String: String]? { get }
    var defaultHeaders: [String: String] { get }
    func body() throws -> Data?
}

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case imageDeserialization
    case timeOut
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "invalidUrl".localized
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .imageDeserialization: return "Cannot deserialize image from Data"
        case .timeOut: return "timeOutRequest".localized
        }
    }
}

extension APICall {
    
    var defaultHeaders: [String: String] {
        return ["os": "iOS",
                "osVersion": Helper.OSVersion(),
                "appVersion": Helper.AppVersion(),
                "deviceId": NSUUID().uuidString,
                "lang": LanguageManager.shared.currentLanguage.rawValue,
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "Bearer " + "\(UserSession.user?.token ?? "")"
        ]
    }
}


extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var fullUrl = url
        if let queryItems = queryItems  {
            let urlQueryItems = queryItems.compactMap { (key, value) in
                URLQueryItem(name: key, value: value)
            }
            fullUrl.append(queryItems: urlQueryItems)
        }
        var request = URLRequest(url: fullUrl)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
