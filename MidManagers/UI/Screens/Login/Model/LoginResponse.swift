//
//  LoginResponse.swift
//  MidManagers
//
//  Created by Khaled Rashed on 10/12/2023.
//

import Foundation

struct LoginResponse: Codable {
    let status: Bool
    let messege: String
    let data: String?
}


