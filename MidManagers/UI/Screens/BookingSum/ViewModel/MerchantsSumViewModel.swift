//
//  MerchantsSumViewModel.swift
//  MidManagers
//
//  Created by Khaled Mohmed on 11/03/2024.
//

import Foundation

extension MerchantsSumView {

    class ViewModel: ObservableObject {
        
        @Published var categoryId: Int
        @Published var dailyReports: [MerchantSum] = []
        @Published var monthlyReports: [MerchantSum] = []
        @Published var yearlyReports: [MerchantSum] = []
        @Published var selectedReport: [MerchantSum] = []
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

        // MARK: - getMerchantLoanSumByCategoryId
        func getMerchantLoanSumByCategoryId() {
            guard NetworkUtility.shared.isConnected(appState: &appState,
                                                    onRetry: {
                self.getMerchantLoanSumByCategoryId()
            }
            ) else { return }
            self.showLoadingIndicator = true
            container.services.bookingSumService.getMerchantLoanSumByCategoryId(categoryId: categoryId)
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

