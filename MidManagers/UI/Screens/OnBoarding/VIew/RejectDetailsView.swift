//
//  RejectDetailsView.swift
//  MidManagers
//
//  Created by Khaled on 09/03/2024.
//

import Foundation
import SwiftUI

struct RejectDetailsView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ViewModel
    
    
    var body: some View {
        ZStack {
            content
            LoadingView(isVisible: $viewModel.showLoadingIndicator)

            if viewModel.showNoInternet {
                LoseConnectionInternetView(didTapRetry: NetworkUtility.shared.retryButtonPressed)
            }

        }.disabled(viewModel.showLoadingIndicator)

        // alert when reports fails
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(
                title: Text("MID Managers"),
                message: Text(viewModel.errorMessage),
                dismissButton: .destructive(Text("alrtBtnOK"))
            )
        }
    }

    var content: some View {
        VStack {
            NavigationBarView(title: "System Reject", container: viewModel.container)

            ScrollView(showsIndicators: false) {
                    ForEach(viewModel.rejectionDetails, id: \.self) { reason in
                        RejectCellView(rejection: reason)
                    }
            }
            Spacer()
        }
    }
}

#if DEBUG
struct RejectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RejectDetailsView(viewModel: RejectDetailsView.ViewModel(container: .preview, rejectionDetails: []))
    }
}
#endif

