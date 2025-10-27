//
//  BookingSumWebRepository.swift
//  MidManagers
//
//  Created by Khaled Rashed on 05/07/2023.
//

import Foundation
import Combine

protocol BookingSumWebRepository: WebRepository {
    func getAllCategoriesLoanSum() -> AnyPublisher<BaseResponse<BookingSum>, Error>
    func getMerchantLoanSumByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsSumData>, Error>
}

struct RealBookingSumWebRepository: BookingSumWebRepository {
    
    var session: URLSession
    var baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func getAllCategoriesLoanSum() -> AnyPublisher<BaseResponse<BookingSum>, Error> {
        return call(endpoint: API.getAllCategoriesLoanSum)
    }
    func getMerchantLoanSumByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsSumData>, Error> {
        return call(endpoint: API.getMerchantLoanSumByCategoryId(categoryId: categoryId))
    }
}

// MARK: - Endpoints
extension RealBookingSumWebRepository {
    
    enum API {
        case getAllCategoriesLoanSum
        case getMerchantLoanSumByCategoryId(categoryId: Int)
    }
}

extension RealBookingSumWebRepository.API: APICall {
    var path: String {
        
        switch self {
            
        case .getAllCategoriesLoanSum:
            return "api/Statistics/GetAllCategoriesLoanSum"
        case .getMerchantLoanSumByCategoryId:
            return "api/Statistics/GetMerchantLoanSumByCategoryId"
        }
        
    }
    
    var method: String {
        switch self {
        case .getAllCategoriesLoanSum:
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
            
        case .getAllCategoriesLoanSum:
            return nil
        case .getMerchantLoanSumByCategoryId(categoryId: let categoryId):
            return ["categoryId": "\(categoryId)"]
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
}
