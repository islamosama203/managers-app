//
//  MerchantsCountView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 13/07/2023.
//

import SwiftUI

struct MerchantsCountView: View {

    @StateObject var viewModel: ViewModel
    @State var categoryId: Int?
    @State private var selectedOption: Int = 0 // Default to daily
    @State var items = [
        MidPickerItem(id: 1, title: "Today", isSelected: true),
        MidPickerItem(id: 2, title: "Monthly", isSelected: false),
        MidPickerItem(id: 3, title: "Yearly", isSelected: false)
    ]

    var body: some View {
        ZStack {
            content
            LoadingView(isVisible: $viewModel.showLoadingIndicator)

            if viewModel.showNoInternet {
                LoseConnectionInternetView(didTapRetry: NetworkUtility.shared.retryButtonPressed)
            }

        }.disabled(viewModel.showLoadingIndicator)
            .onAppear {
                viewModel.getMerchantLoanCountByCategoryId()
                selectToday()
        }

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
            NavigationBarView(title: "Merchants Count", container: viewModel.container)
            MidPickerView(items: $items, onItemSelected: { index in
                selectedOption = index
                switch index {
                case 0:
                    viewModel.selectedReport = viewModel.dailyReports
                case 1:
                    viewModel.selectedReport = viewModel.monthlyReports
                case 2:
                    viewModel.selectedReport = viewModel.yearlyReports

                default:
                    viewModel.selectedReport = viewModel.dailyReports
                }
            })
            Spacer().frame(height: 20)

            ScrollView(showsIndicators: false) {
                ForEach(viewModel.selectedReport, id: \.self) { report in
                    MerchantCountCellView(merchant: report)
                }.padding(.bottom)
            }
        }
    }
    
    // Helper function to select "Today" item
    private func selectToday() {
        for index in items.indices {
            if items[index].title == "Today" {
                items[index].isSelected = true
            } else {
                items[index].isSelected = false
            }
        }
    }
}

#if DEBUG
struct MerchantsCountView_Previews: PreviewProvider {
    static var previews: some View {
        MerchantsCountView(viewModel: MerchantsCountView.ViewModel(container: .preview, categoryId: 1))
    }
}
#endif


