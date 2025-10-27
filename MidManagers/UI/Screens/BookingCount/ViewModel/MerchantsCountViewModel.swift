//
//  MerchantsCountViewModel.swift
//  MidManagers
//
//  Created by Khaled on 10/03/2024.
//

import Foundation

extension MerchantsCountView {

    class ViewModel: ObservableObject {
        
        @Published var categoryId: Int
        @Published var dailyReports: [MerchantCount] = []
        @Published var monthlyReports: [MerchantCount] = []
        @Published var yearlyReports: [MerchantCount] = []
        @Published var selectedReport: [MerchantCount] = []
        @Published var showLoadingIndicator = false
        @Published var showingAlert = false
        @Published var errorMessage = ""
        @Published var showNoInternet: Bool
        
        var appState: Store<AppState>
        
        // Misc
        let container: DIContainer // -> dependacy injection
        private var cancelBag = CancelBag() // -> combine unsubscribe
        
        init(container: DIContainer, categoryId: Int) {
            self.container = container
            self.categoryId = categoryId
            appState = container.appState
            
            // call the value of the showNoInternet form the appState
            showNoInternet = appState.value.showNoInternet
            
            appState.map(\.showNoInternet)
                .removeDuplicates()
                .weakAssign(to: \.showNoInternet, on: self)
                .store(in: cancelBag)
                
            
        }

        // MARK: - getMerchantLoanCountByCategoryId
        func getMerchantLoanCountByCategoryId() {
            guard NetworkUtility.shared.isConnected(appState: &appState,
                                                    onRetry: {
                self.getMerchantLoanCountByCategoryId()
            }
            ) else { return }
            self.showLoadingIndicator = true
            container.services.bookingCountService.getMerchantLoanCountByCategoryId(categoryId: categoryId)
                .sink { result in
                    if let error =  result.error {
                        self.errorMessage = error.localizedDescription
                        self.showingAlert = true
                        self.showLoadingIndicator = false
                    }
                }
        receiveValue: { merchantsResponse in
            self.showLoadingIndicator = false
            if merchantsResponse.status {
                print("Merchants Report Response success 🎉")
                self.dailyReports = merchantsResponse.data?.daily ?? []
                self.monthlyReports = merchantsResponse.data?.monthly ?? []
                self.yearlyReports = merchantsResponse.data?.yearly ?? []
                self.selectedReport = self.dailyReports
                
            } else {
                self.showingAlert = true
                self.errorMessage = merchantsResponse.messege
                print("Merchants Report Response Failed! 😢")
            }
        }.store(in: cancelBag)
            
        }
        
        
    }
}

