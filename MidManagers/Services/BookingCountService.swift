//
//  BookingCountService.swift
//  MidManagers
//
//  Created by Khaled Rashed on 06/07/2023.
//

import Foundation
import Combine


protocol BookingCountService {
    func getAllCategoriesLoanCount() -> AnyPublisher<BaseResponse<BookingCount>, Error>
    func getMerchantLoanCountByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsCountData>, Error>
}

struct RealBookingCountService: BookingCountService {
    
    let webRepository: BookingCountWebRepository
    
    init(webRepository: BookingCountWebRepository) {
        self.webRepository = webRepository
    }

    func getAllCategoriesLoanCount() -> AnyPublisher<BaseResponse<BookingCount>, Error> {
        return webRepository.getAllCategoriesLoanCount()
    }
    func getMerchantLoanCountByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsCountData>, Error> {
        return webRepository.getMerchantLoanCountByCategoryId(categoryId: categoryId)
    }

}

struct StubBookingCountService: BookingCountService {
    
    func getAllCategoriesLoanCount() -> AnyPublisher<BaseResponse<BookingCount>, Error> {
        return Empty().eraseToAnyPublisher()
    }
    func getMerchantLoanCountByCategoryId(categoryId: Int) -> AnyPublisher<BaseResponse<MerchantsCountData>, Error> {
        return Empty().eraseToAnyPublisher()
    }
}
