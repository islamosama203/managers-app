//
//  AppEnvironment.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 09.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        /*
         To see the deep linking in action:
         
         1. Launch the app in iOS 13.4 simulator (or newer)
         2. Subscribe on Push Notifications with "Allow Push" button
         3. Minimize the app
         4. Drag & drop "push_with_deeplink.apns" into the Simulator window
         5. Tap on the push notification
         
         Alternatively, just copy the code below before the "return" and launch:
         
            DispatchQueue.main.async {
                deepLinksHandler.open(deepLink: .showCountryFlag(alpha3Code: "AFG"))
            }
        */
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let services = configuredServices(appState: appState,
                                                webRepositories: webRepositories)
        let diContainer = DIContainer(appState: appState, services: services)
        let deepLinksHandler = RealDeepLinksHandler(container: diContainer)
        let pushNotificationsHandler = RealPushNotificationsHandler(deepLinksHandler: deepLinksHandler)
        let systemEventsHandler = RealSystemEventsHandler(
            container: diContainer, deepLinksHandler: deepLinksHandler,
            pushNotificationsHandler: pushNotificationsHandler,
            pushTokenWebRepository: webRepositories.pushTokenWebRepository)
        return AppEnvironment(container: diContainer,
                              systemEventsHandler: systemEventsHandler)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        // the time of request before timeOut, and server
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let loginWebRepository = RealLoginWebRepository(
            session: session,
            baseURL: Constants.mainUrl)
        let homeWebRepository = RealHomeWebRepository(
            session: session,
            baseURL: Constants.mainUrl)
        let bookingCountWebRepository = RealBookingCountWebRepository(
            session: session,
            baseURL: Constants.mainUrl)
        let bookingSumWebRepository = RealBookingSumWebRepository(
            session: session,
            baseURL: Constants.mainUrl)
        let pushTokenWebRepository = RealPushTokenWebRepository(
            session: session,
            baseURL: "")
        return .init(
                     loginWebRepository: loginWebRepository,
                     homeWebRepository: homeWebRepository,
                     bookingCountWebRepository: bookingCountWebRepository,
                     bookingSumWebRepository: bookingSumWebRepository,
                     pushTokenWebRepository: pushTokenWebRepository)
    }
    

    
    private static func configuredServices(appState: Store<AppState>,
                                           webRepositories: DIContainer.WebRepositories
    ) -> DIContainer.Services {
        
        let loginService = RealLoginService(
            webRepository: webRepositories.loginWebRepository)

        let homeService = RealHomeService(
            webRepository: webRepositories.homeWebRepository)
        
        let bookingCountService = RealBookingCountService(
            webRepository: webRepositories.bookingCountWebRepository)
        
        let bookingSumService = RealBookingSumService(
            webRepository: webRepositories.bookingSumWebRepository)
        
        let userPermissionsService = RealUserPermissionsService(
            appState: appState, openAppSettings: {
                URL(string: UIApplication.openSettingsURLString).flatMap {
                    UIApplication.shared.open($0, options: [:], completionHandler: nil)
                }
            })
        
        return .init(
                     loginService: loginService,
                     homeService: homeService,
                     bookingCountService: bookingCountService,
                     bookingSumService: bookingSumService,
                     userPermissionsService: userPermissionsService)
    }
}

extension DIContainer {
    struct WebRepositories {
        let loginWebRepository: LoginWebRepository
        let homeWebRepository: HomeWebRepository
        let bookingCountWebRepository: BookingCountWebRepository
        let bookingSumWebRepository: BookingSumWebRepository
        let pushTokenWebRepository: PushTokenWebRepository
    }
    
}
