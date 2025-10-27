//
//  DailyManagementReport.swift
//  MidManagers
//
//  Created by Khaled Rashed on 10/04/2023.
//

import Foundation

// MARK: - DailyManagementReport
struct DailyManagementReport: Codable {
    let registeredCount, loanCount, activeClientCount: Int
    let loanSum: Double
    
}


// MARK: - Reports
struct Report: Codable, Identifiable {
    let name, dailyNumber, monthlyNumber, totalNumber: String
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case name
        case dailyNumber
        case monthlyNumber
        case totalNumber
        case id
    }
}
