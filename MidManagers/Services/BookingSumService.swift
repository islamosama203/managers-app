//
//  BookingSumService.swift
//  MidManagers
//
//  Created by Khaled Rashed on 05/07/2023.
//

import Foundation
import Combine

protocol BookingSumService {

    func getAllCategoriesLoanSum() -> AnyPublisher<BaseResponse<BookingSum>, Error>
    func getMerchantLoanSumByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsSumData>, Error>
}

struct RealBookingSumService: BookingSumService {
    
    let webRepository: BookingSumWebRepository
    
    init(webRepository: BookingSumWebRepository) {
        self.webRepository = webRepository
    }
    
    func getAllCategoriesLoanSum() -> AnyPublisher<BaseResponse<BookingSum>, Error> {
        return webRepository.getAllCategoriesLoanSum()
    }
    func getMerchantLoanSumByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsSumData>, Error> {
        return webRepository.getMerchantLoanSumByCategoryId(categoryId: categoryId)
    }
}

struct StubBookingSumService: BookingSumService {

    func getAllCategoriesLoanSum() -> AnyPublisher<BaseResponse<BookingSum>, Error> {
        return Empty().eraseToAnyPublisher()
    }
    func getMerchantLoanSumByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsSumData>, Error> {
        return Empty().eraseToAnyPublisher()
    }
}
