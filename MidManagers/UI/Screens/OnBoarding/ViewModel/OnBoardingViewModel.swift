//
//  OnBoardingViewModel.swift
//  MidManagers
//
//  Created by Khaled Rashed on 11/07/2023.
//

import Foundation
import SwiftUI

extension DetailsView {

    class ViewModel: ObservableObject {
        
        @Published var dailyReports: UserPerStatus?
        @Published var monthlyReports: UserPerStatus?
        @Published var totalReports: UserPerStatus?
        @Published var selectedReports: UserPerStatus?
        @Published var showLoadingIndicator = false
        @Published var showingAlert = false
        @Published var errorMessage = ""
        @Published var showNoInternet: Bool
        @Published var navigateToDetails = false
        @Published var navigateToLoansCount = false
        @Published var navigateToLoansSum = false

        var appState: Store<AppState>
        
        // Misc
        let container: DIContainer // -> dependacy injection
        private var cancelBag = CancelBag() // -> combine unsubscribe

        init(container: DIContainer) {
            self.container = container
            appState = container.appState
            
            // call the value of the showNoInternet form the appState
            showNoInternet = appState.value.showNoInternet
            
            appState.map(\.showNoInternet)
                .removeDuplicates()
                .weakAssign(to: \.showNoInternet, on: self)
                .store(in: cancelBag)
            
            getDailyManagementReportDetails()
        }
        
        
        func getDailyManagementReportDetails() {
            guard NetworkUtility.shared.isConnected(appState: &appState, onRetry: getDailyManagementReportDetails) else { return }
            self.showLoadingIndicator = true
            container.services.homeService.getDailyManagementReportDetails()
                .sink { result in
                    if let error =  result.error {
                        self.errorMessage = error.localizedDescription
                        self.showingAlert = true
                        self.showLoadingIndicator = false
                    }
                }
            receiveValue: { reportResponse in
                self.showLoadingIndicator = false
                if reportResponse.status {
                    print("Daily Management Report Details Response success 🎉")
                    self.dailyReports = reportResponse.data?.dailyUserPerStatus
                    self.monthlyReports = reportResponse.data?.monthlyUserPerStatus
                    self.totalReports = reportResponse.data?.totalUserPerStatus
                    self.selectedReports = self.dailyReports


                } else {
                    self.showingAlert = true
                    self.errorMessage = reportResponse.messege
                    print("Daily Management Report Details Response Failed! 😢 ")
                }
            }.store(in: cancelBag)
        }
    }
}
