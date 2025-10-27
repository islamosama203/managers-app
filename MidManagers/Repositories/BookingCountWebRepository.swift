//
//  BookingCountWebRepository.swift
//  MidManagers
//
//  Created by Khaled Rashed on 06/07/2023.
//

import Foundation
import Combine

protocol BookingCountWebRepository: WebRepository {
    func getAllCategoriesLoanCount() -> AnyPublisher<BaseResponse<BookingCount>, Error>
    func getMerchantLoanCountByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsCountData>, Error>
}

struct RealBookingCountWebRepository: BookingCountWebRepository {
    
    var session: URLSession
    var baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getAllCategoriesLoanCount() -> AnyPublisher<BaseResponse<BookingCount>, Error> {
        return call(endpoint: API.getAllCategoriesLoanCount)
    }
    func getMerchantLoanCountByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsCountData>, Error> {
        return call(endpoint: API.getMerchantLoanSumByCategoryId(categoryId: categoryId))
    }
}

// MARK: - Endpoints
extension RealBookingCountWebRepository {
    
    enum API {
        case getAllCategoriesLoanCount
        case getMerchantLoanSumByCategoryId(categoryId: Int)
    }
}

extension RealBookingCountWebRepository.API: APICall {
    var path: String {
        
        switch self {
            
        case .getAllCategoriesLoanCount:
            return "api/Statistics/GetAllCategoriesLoanCount"
        case .getMerchantLoanSumByCategoryId:
            return "api/Statistics/GetMerchantLoanCountByCategoryId"
        }
        
    }
    
    var method: String {
        switch self {
        case .getAllCategoriesLoanCount:
            return "GET"
        case .getMerchantLoanSumByCategoryId:
            return "GET"
        }
    }
    
    var headers: [String: String]? {
        return defaultHeaders
    }
    
    var queryItems: [String : String]? {
        switch self {
            
        case .getAllCategoriesLoanCount:
            return nil
        case .getMerchantLoanSumByCategoryId(categoryId: let categoryId):
            return ["categoryId": "\(categoryId)"]
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
}
