//
//  BookingSum.swift
//  MidManagers
//
//  Created by Khaled Mohmed on 11/03/2024.
//

import Foundation

// MARK: - BookingSum
struct BookingSum: Codable {
    let daily, montly, yearly: [CategorySum]
}

// MARK: - CategorySum
struct CategorySum: Codable, Hashable {
    let categoryCode: Int
    let categoryName: String
    let categoryTotalSum: Double
}


// MARK: - MerchantsSumData
struct MerchantsSumData: Codable {
    let daily, monthly, yearly: [MerchantSum]
}

// MARK: - MerchantSum
struct MerchantSum: Codable, Hashable {
    let merchantCode: Int
    let merchantName: String
    let laonSum: Double
}
