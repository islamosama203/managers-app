//
//  BaseViewModel.swift
//  MidManagers
//
//  Created by Khaled Rashed on 08/08/2023.
//

import Foundation
import Combine

class BaseViewModel : ObservableObject {
    
    @Published var showingAlert = false
    @Published var errorMessage = ""
    @Published var showLoadingIndicator = false
    @Published var showNoInternet: Bool
    
    var appState: Store<AppState>
    
    // Misc
    let container: DIContainer // -> dependacy injection
    var cancelBag = CancelBag() // -> combine unsubscribe
    
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
    
    func checkNetworkAvailability(_ onRetry: (() -> ())? ) {
        guard NetworkUtility.shared.isConnected(appState: &appState, onRetry: onRetry) else { return }
    }
    
    func showLoadIndicator() {
        self.showLoadingIndicator = true
    }
    
    func hideLoadIndicator() {
        self.showLoadingIndicator = false
    }
    
    func showError(_ message: String) {
        self.showingAlert = true
        self.errorMessage = message
        print("Response Failed! 😢")
    }
    
    func handleErrorResponse(_ result: Subscribers.Completion<Error> ) {
        if let error = result.error {
            self.errorMessage = error.localizedDescription
            self.showingAlert = true
            self.hideLoadIndicator()
        }
    }
    
}
