//
//  BookingSumView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 04/07/2023.
//

import SwiftUI

struct BookingSumView: View {

    @StateObject var viewModel: ViewModel
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
            viewModel.getAllCategoriesLoanSum()
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
            NavigationBarView(title: "Booking Sum", container: viewModel.container)
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

            // Checking if the selected report is empty
            if viewModel.selectedReport.isEmpty {
                Spacer()
                emptyStateView
                
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.selectedReport, id: \.self) { report in
                        CategorySumCellView(category: report)
                            .onTapGesture {
                                viewModel.container.appState[\.currentRoute] = .merchantSum(categoryId: report.categoryCode)
                        }
                    }.padding(.bottom)
                }
            }
        }
    }

    // Empty state view when there are no reports
    var emptyStateView: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(.mainPurple))
            Text("No data available now!")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(.mainPurple))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Ensure content starts from the top
        .padding()
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
    struct BookingSumView_Previews: PreviewProvider {
        static var previews: some View {
            BookingSumView(viewModel: BookingSumView.ViewModel(container: .preview))
        }
    }
#endif
