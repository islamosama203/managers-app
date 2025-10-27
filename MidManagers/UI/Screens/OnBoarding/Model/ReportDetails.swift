//
//  ReportDetails.swift
//  MidManagers
//
//  Created by Khaled on 06/03/2024.
//

import Foundation
import SwiftUI

// MARK: - ReportDetails
struct ReportDetails: Codable {
    let totalUserPerStatus: UserPerStatus
    let name: String
    let dailyUserPerStatus, monthlyUserPerStatus: UserPerStatus
}

// MARK: - UserPerStatus
struct UserPerStatus: Codable {
    let approvedCount, activeAmount, rejectRate, approvedAmount: ActivationUsersCount
    let waitingForReview, active, inCompleteCustomers, riskReject: ActivationUsersCount
    let activationUsersCount, closureRate, systemRejectRate, inActiveRate: ActivationUsersCount
    let pendingAtRisk: ActivationUsersCount
    let systemReject: [ActivationUsersCount]
    let riskRejectRate, systemRejectCount, activationUsersLimit, approvalRate: ActivationUsersCount
    let rejectCount: ActivationUsersCount
    
    // MARK: - Approved data
    var approvedCountValue: String {
        return approvedCount.usersCount.int.description.currencyStyle()
    }
    var approvedAmountValue: String {
        return approvedAmount.usersCount.int.description.currencyStyle()
    }
    var approvalRateValue: String {
        return String(format: "%.2f", approvalRate.usersCount) + "%"
    }
    // MARK: - Active data
    var activeCountValue: String {
        return active.usersCount.int.description.currencyStyle()
    }
    var activeAmountValue: String {
        return activeAmount.usersCount.int.description.currencyStyle()
    }
    var activeRateValue: String {
        return String(format: "%.2f", closureRate.usersCount) + "%"
    }
    // MARK: - Inactive data
    var inactiveCountValue: String {
        return activationUsersCount.usersCount.int.description.currencyStyle()
    }
    var inactiveAmountValue: String {
        return activationUsersLimit.usersCount.int.description.currencyStyle()
    }
    var inactiveRateValue: String {
        return String(format: "%.2f", inActiveRate.usersCount) + "%"
    }
    // MARK: - Pending data
    var contractValue: String {
        return waitingForReview.usersCount.int.description.currencyStyle()
    }
    var approvalValue: String {
        return pendingAtRisk.usersCount.int.description.currencyStyle()
    }
    var customersValue: String {
        return inCompleteCustomers.usersCount.int.description.currencyStyle()
    }
    // MARK: - Reject data
    var rejectCountValue: String {
        return rejectCount.usersCount.int.description.currencyStyle()
    }
    var rejectRateValue: String {
        return String(format: "%.2f", rejectRate.usersCount) + "%"
    }
    // MARK: - System Reject data
    var systemRejectCountValue: String {
        return systemRejectCount.usersCount.int.description.currencyStyle()
    }
    var systemRejectRateValue: String {
        return String(format: "%.2f", systemRejectRate.usersCount) + "%"
    }
    // MARK: - Risk Reject data
    var riskRejectCountValue: String {
        return riskReject.usersCount.int.description.currencyStyle()
    }
    var riskRejectRateValue: String {
        return String(format: "%.2f", riskRejectRate.usersCount) + "%"
    }
 
}

// MARK: - ActivationUsersCount
struct ActivationUsersCount: Codable, Hashable {
    let usersCount: Double
    let statusName: String
}




// MARK: - OnBoardingSectionItem
struct OnBoardingSectionItem {
    var title: String
    var titleType: SectionTitleType
    var items: [OnBoardingItem]
    var sectionType: SectionType
}

// MARK: - OnBoardingItem
struct OnBoardingItem: Identifiable {
    var id = UUID()
    var title: String
    var value: String
}

// MARK: - SectionType
enum SectionType {
    case approval
    case pending
    case reject
}
