//
//  BookingData.swift
//  MidManagers
//
//  Created by Khaled Rashed on 05/07/2023.
//

import Foundation

// MARK: - BookingCount
struct BookingCount: Codable {
    let daily, monthly, yearly: [CategoryCount]
}

// MARK: - CategoryCount
struct CategoryCount: Codable, Hashable {
    let categoryCode: Int
    let categoryName: String
    let categoryTotalCount: Int
}


// MARK: - MerchantsCountData
struct MerchantsCountData: Codable {
    let daily, monthly, yearly: [MerchantCount]
    
}

// MARK: - MerchantCount
struct MerchantCount: Codable, Hashable {
    let merchantCode: Int
    let merchantName: String
    let laonCount: Int
}
