//
//  RejectDetailsViewModel.swift
//  MidManagers
//
//  Created by Khaled on 09/03/2024.
//

import Foundation
import SwiftUI

extension RejectDetailsView {

    class ViewModel: ObservableObject {

        @Published var showLoadingIndicator = false
        @Published var showingAlert = false
        @Published var errorMessage = ""
        @Published var showNoInternet: Bool
        @Published var rejectionDetails: [ActivationUsersCount]

        var appState: Store<AppState>
        
        // Misc
        let container: DIContainer // -> dependacy injection
        private var cancelBag = CancelBag() // -> combine unsubscribe

        init(container: DIContainer, rejectionDetails: [ActivationUsersCount]) {
            self.container = container
            self.rejectionDetails = rejectionDetails
            appState = container.appState
            
            // call the value of the showNoInternet form the appState
            showNoInternet = appState.value.showNoInternet
            
            appState.map(\.showNoInternet)
                .removeDuplicates()
                .weakAssign(to: \.showNoInternet, on: self)
                .store(in: cancelBag)
        }
    }
}
