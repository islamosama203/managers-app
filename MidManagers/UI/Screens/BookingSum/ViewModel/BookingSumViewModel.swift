//
//  BookingSumViewModel.swift
//  MidManagers
//
//  Created by Khaled Rashed on 04/07/2023.
//

import Foundation

extension BookingSumView {

    class ViewModel: ObservableObject {
        
        
        @Published var dailyReports: [CategorySum] = []
        @Published var monthlyReports: [CategorySum] = []
        @Published var yearlyReports: [CategorySum] = []
        @Published var selectedReport: [CategorySum] = []
        @Published var merchants: [MerchantsSumData] = []
        @Published var showLoadingIndicator = false
        @Published var showingAlert = false
        @Published var errorMessage = ""
        @Published var showNoInternet: Bool
        
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
                
            
        }
        
        // MARK: - getAllCategoriesLoanSum
        func getAllCategoriesLoanSum() {
            guard !showLoadingIndicator else { return }
            guard NetworkUtility.shared.isConnected(appState: &appState, onRetry: getAllCategoriesLoanSum) else { return }
            self.showLoadingIndicator = true
            container.services.bookingSumService.getAllCategoriesLoanSum()
                .sink { result in
                    if let error =  result.error {
                        self.errorMessage = error.localizedDescription
                        self.showingAlert = true
                        self.showLoadingIndicator = false
                    }
                }
        receiveValue: { categoriesResponse in
            self.showLoadingIndicator = false
            if categoriesResponse.status {
                print("Categories Loan Count Response success 🎉")
                self.dailyReports = categoriesResponse.data?.daily ?? []
                self.monthlyReports = categoriesResponse.data?.montly ?? []
                self.yearlyReports = categoriesResponse.data?.yearly ?? []
                self.selectedReport = self.dailyReports

            } else {
                self.showingAlert = true
                self.errorMessage = categoriesResponse.messege
                print("Categories Loan Count Response Failed! 😢")
            }
        }.store(in: cancelBag)
            
        }
    }
}

