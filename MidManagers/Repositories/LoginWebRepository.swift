//
//  LoginWebRepository.swift
//  MidManagers
//
//  Created by Khaled Rashed on 10/12/2023.
//

import Foundation
import Combine


protocol LoginWebRepository: WebRepository {
    func login(mobileNumber: String, password: String) -> AnyPublisher<LoginResponse, Error>
}

struct RealLoginWebRepository: LoginWebRepository {
    
    var session: URLSession
    var baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func login(mobileNumber: String, password: String) -> AnyPublisher<LoginResponse, Error> {
        return call(endpoint: API.login(mobileNumber: mobileNumber, password: password))
    }
    
}


// MARK: - Endpoints

extension RealLoginWebRepository {
    
    enum API {
        case login(mobileNumber: String, password: String)
     }
}

extension RealLoginWebRepository.API: APICall {
    var path: String {
        switch self {
        case .login:
            return "api/Auth/Login"
        }
    }
    
    var method: String {
        switch self {
        case .login:
            return "POST"
        }
    }
    
    var headers: [String: String]? {
       let headers = ["os": "iOS",
                "osVersion": Helper.OSVersion(),
                "appVersion": Helper.AppVersion(),
                "deviceId": NSUUID().uuidString,
                "lang": LanguageManager.shared.currentLanguage.rawValue,
                "Accept": "application/json",
                "Content-Type": "application/json"
        ]
        return headers
        
    }
    
    var queryItems: [String : String]? {
        return nil
    }
    func body() throws -> Data? {
        switch self {
        case .login(let mobileNumber, let password):
            let parameters = ["MobileNumber": mobileNumber, "Password": password]
            return try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)

        }
    }
}
