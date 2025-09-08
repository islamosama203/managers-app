//
//  BaseResponse.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let status: Bool
    let data: T?
    let messege: String
    
}
