//
//  HomeWebRepository.swift
//  MidManagers
//
//  Created by Khaled Rashed on 09/04/2023.
//

import Foundation
import Combine

protocol HomeWebRepository: WebRepository {
    func getDailyManagementReport() -> AnyPublisher<BaseResponse<[Report]>, Error>
    func getDailyManagementReportDetails() -> AnyPublisher<BaseResponse<ReportDetails>, Error>
}

struct RealHomeWebRepository: HomeWebRepository {
    
    var session: URLSession
    var baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getDailyManagementReport() -> AnyPublisher<BaseResponse<[Report]>, Error> {
        return call(endpoint: API.getDailyManagementReport)
    }
    func getDailyManagementReportDetails() -> AnyPublisher<BaseResponse<ReportDetails>, Error> {
        return call(endpoint: API.getDailyManagementReportDetails)
    }
}

// MARK: - Endpoints
extension RealHomeWebRepository {
    
    enum API {
        case getDailyManagementReport
        case getDailyManagementReportDetails
    }
}

extension RealHomeWebRepository.API: APICall {
    var path: String {
        switch self {
        case .getDailyManagementReport:
            return "api/Statistics/GetManagementReportV2"
        case .getDailyManagementReportDetails:
            return "api/Statistics/GetUsersPerStatus"
            
        }
    }
    
    var method: String {
        switch self {
        case .getDailyManagementReport:
            return "GET"
        case.getDailyManagementReportDetails:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return defaultHeaders
    }
    
    var queryItems: [String : String]? {
        return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .getDailyManagementReport:
            return nil
        case .getDailyManagementReportDetails:
            return nil
        }
    }
}
