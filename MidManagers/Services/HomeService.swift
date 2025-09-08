//
//  HomeService.swift
//  MidManagers
//
//  Created by Khaled Rashed on 09/04/2023.
//

import Foundation
import Combine

protocol HomeService {

    func getDailyManagementReport() -> AnyPublisher<BaseResponse<[Report]>, Error>
    func getDailyManagementReportDetails() -> AnyPublisher<BaseResponse<ReportDetails>, Error>
}

struct RealHomeService: HomeService {

    let webRepository: HomeWebRepository

    init(webRepository: HomeWebRepository) {
        self.webRepository = webRepository
    }

    func getDailyManagementReport() -> AnyPublisher<BaseResponse<[Report]>, Error> {
        return webRepository.getDailyManagementReport()
    }
    func getDailyManagementReportDetails() -> AnyPublisher<BaseResponse<ReportDetails>, Error> {
        return webRepository.getDailyManagementReportDetails()
    }

}

struct StubHomeService: HomeService {

    func getDailyManagementReport() -> AnyPublisher<BaseResponse<[Report]>, Error> {
        return Empty().eraseToAnyPublisher()
    }
    func getDailyManagementReportDetails() -> AnyPublisher<BaseResponse<ReportDetails>, Error> {
        return Empty().eraseToAnyPublisher()
    }

}
