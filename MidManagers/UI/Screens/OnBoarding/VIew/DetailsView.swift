//
//  DetailsView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 18/06/2023.
//

import SwiftUI

struct DetailsView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
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
            viewModel.getDailyManagementReportDetails()
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
            NavigationBarView(title: "On Boarding", container: viewModel.container)
            MidPickerView(items: $items, onItemSelected: { index in
                selectedOption = index
                switch index {
                case 0:
                    viewModel.selectedReports = viewModel.dailyReports
                case 1:
                    viewModel.selectedReports = viewModel.monthlyReports
                case 2:
                    viewModel.selectedReports = viewModel.totalReports
                default:
                    viewModel.selectedReports = nil
                }
            })
            Spacer().frame(height: 20)
            scrollView.id(viewModel.showLoadingIndicator)
            Spacer()

        }
    }

    var scrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {

            VStack {


                if let reports = viewModel.selectedReports {
                    // Update OnBoardingSectionView items using reports
                    
                    OnBoardingSectionView(model: OnBoardingSectionItem(title: "Approval", titleType: .main, items:
                        [OnBoardingItem(title: "Count", value: reports.approvedCountValue),
                         OnBoardingItem(title: "Amount", value: reports.approvedAmountValue),
                         OnBoardingItem(title: "Rate", value: reports.approvalRateValue)], sectionType: .approval), tapAction: {})

                    Spacer().frame(height: 10)
                    
                    OnBoardingSectionView(model: OnBoardingSectionItem(title: "Active", titleType: .sub, items:
                        [OnBoardingItem(title: "Count", value: reports.activeCountValue),
                         OnBoardingItem(title: "Amount", value: reports.activeAmountValue),
                         OnBoardingItem(title: "Rate", value: reports.activeRateValue)], sectionType: .approval), tapAction: {})
                    
                    Spacer().frame(height: 10)

                    OnBoardingSectionView(model: OnBoardingSectionItem(title: "Inactive", titleType: .sub, items:
                        [OnBoardingItem(title: "Count", value: reports.inactiveCountValue),
                         OnBoardingItem(title: "Amount", value: reports.inactiveAmountValue),
                         OnBoardingItem(title: "Rate", value: reports.inactiveRateValue)], sectionType: .approval), tapAction: {})
                    
                    Spacer().frame(height: 25)
                    Color(.mainPurple)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 1.5)
                        .opacity(0.2)
                        .cornerRadius(2, corners: .allCorners)
                    Spacer().frame(height: 25)
                    
                    OnBoardingSectionView(model: OnBoardingSectionItem(title: "Pending", titleType: .main, items:
                        [OnBoardingItem(title: "Contract", value: reports.contractValue),
                         OnBoardingItem(title: "Approval", value: reports.approvalValue),
                         OnBoardingItem(title: "Customer", value: reports.customersValue)], sectionType: .pending), tapAction: {})

                    Spacer().frame(height: 25)
                    Color(.mainPurple)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 1.5)
                        .opacity(0.2)
                        .cornerRadius(2, corners: .allCorners)
                    Spacer().frame(height: 25)
                    
                    OnBoardingSectionView(model: OnBoardingSectionItem(title: "Reject", titleType: .main, items:
                        [OnBoardingItem(title: "Count", value: reports.rejectCountValue),
                         OnBoardingItem(title: "Rate", value: reports.rejectRateValue)], sectionType: .reject), tapAction: {})

                    Spacer().frame(height: 10)
                    
                    OnBoardingSectionView(model: OnBoardingSectionItem(title: "System Reject", titleType: .sub, items:
                        [OnBoardingItem(title: "Count", value: reports.systemRejectCountValue),
                         OnBoardingItem(title: "Rate", value: reports.systemRejectRateValue)], sectionType: .reject),
                             tapAction: {
                        viewModel.container.appState[\.currentRoute] = .rejectDetailsView(rejectionDetails: reports.systemReject)
                    })

                    Spacer().frame(height: 10)
                    
                    OnBoardingSectionView(model: OnBoardingSectionItem(title: "Risk Reject", titleType: .sub, items:
                        [OnBoardingItem(title: "Count", value: reports.riskRejectCountValue),
                         OnBoardingItem(title: "Rate", value: reports.riskRejectRateValue)], sectionType: .reject), tapAction: {})

                    Spacer().frame(height: 30)
                    
                }
            }.id(selectedOption)
        }
    }
}

#if DEBUG
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsView.ViewModel(container: .preview))
    }
}
#endif

