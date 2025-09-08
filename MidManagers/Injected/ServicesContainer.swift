//
//  DIContainer.Services.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 24.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

extension DIContainer {
    
    struct Services {
        let loginService: LoginService
        let homeService: HomeService
        let bookingCountService: BookingCountService
        let bookingSumService: BookingSumService
        let userPermissionsService: UserPermissionsService
        
        init(
             loginService: LoginService,
             homeService: HomeService,
             bookingCountService: BookingCountService,
             bookingSumService: BookingSumService,
             
            userPermissionsService: UserPermissionsService) {
            self.loginService = loginService
            self.homeService = homeService
            self.bookingCountService = bookingCountService
            self.bookingSumService = bookingSumService
            self.userPermissionsService = userPermissionsService
        }
        
        static var stub: Self {
            .init(
                  loginService: StubLoginService(),
                  homeService: StubHomeService(),
                  bookingCountService: StubBookingCountService(),
                  bookingSumService: StubBookingSumService(),
                  userPermissionsService: StubUserPermissionsService())
        }
    }
}
