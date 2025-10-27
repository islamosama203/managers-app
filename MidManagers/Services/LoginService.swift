//
//  LoginService.swift
//  MidManagers
//
//  Created by Khaled Rashed on 10/12/2023.
//

import Foundation
import Combine


protocol LoginService {

    func login(mobileNumber: String, password: String) -> AnyPublisher<LoginResponse, Error>
    
}

struct RealLoginService: LoginService {
    
    let webRepository: LoginWebRepository
    
    init(webRepository: LoginWebRepository) {
        self.webRepository = webRepository
    }
    
    func login(mobileNumber: String, password: String) -> AnyPublisher<LoginResponse, Error> {
        return webRepository.login(mobileNumber: mobileNumber, password: password)
    }
    
}

struct StubLoginService: LoginService {
    
    func login(mobileNumber: String, password: String) -> AnyPublisher<LoginResponse, Error> {
        return Empty().eraseToAnyPublisher()
    }
    
}
