//
//  HomeViewModel.swift
//  MidManagers
//
//  Created by Khaled Rashed on 10/04/2023.
//

import Foundation
import SwiftUI

extension HomeView {

    class ViewModel: BaseViewModel {

        @Published var reports: [Report] = []
        @Published var navigateToDetails = false
        @Published var navigateToLoansCount = false
        @Published var navigateToLoansSum = false
        
        
        func viewDidAppear() {
            getDailyManagementReport()
        }
        
        
        func getDailyManagementReport() {
            checkNetworkAvailability(getDailyManagementReport)
            showLoadIndicator()
            container.services.homeService.getDailyManagementReport()
                .sink { result in
                    self.handleErrorResponse(result)
                }
            receiveValue: { reportResponse in
                self.hideLoadIndicator()
                if reportResponse.status {
                    print("Daily Management Report Response success 🎉")
                    self.reports = reportResponse.data ?? []

                } else {
                    self.showError(reportResponse.messege)
                    print("Daily Management Report Response Failed! 😢 ")
                }
            }.store(in: cancelBag)
        }
    }
}
