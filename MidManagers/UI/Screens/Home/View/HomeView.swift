//
//  HomeView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 10/04/2023.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct HomeView: View {
    
    @StateObject var viewModel: ViewModel
    @State var currentMode: StaticsMode = .today
    @State var items = [
        MidPickerItem(id: 1, title: "Today", isSelected: true),
        MidPickerItem(id: 2, title: "Monthly", isSelected: false),
        MidPickerItem(id: 3, title: "Yearly", isSelected: false)
    ]
    
    var body: some View {
            ZStack {
                content
                LoadingView(isVisible: $viewModel.showLoadingIndicator)
                
                // alert when reports fails
                    .alert(isPresented: $viewModel.showingAlert) {
                        Alert(
                            title: Text("MID Managers"),
                            message: Text(viewModel.errorMessage),
                            dismissButton: .destructive(Text("alrtBtnOK"))
                        )
                    }

            }.disabled(viewModel.showLoadingIndicator)
                .onAppear {
                    viewModel.viewDidAppear()
                }
            
            if viewModel.showNoInternet {
                LoseConnectionInternetView(didTapRetry: NetworkUtility.shared.retryButtonPressed)
            }

        
    } // body
    
    var content: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer().frame(width: 35)
                    Image("logoRed")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 50)
                    Spacer()
                    Button(action: {
                        UserSession.logout()
                    }, label: {
                        HStack {
                            Text(Image(systemName: "power.circle.fill"))
                                .foregroundColor(.red)
                                .font(.custom("Poppins-Bold", size: 25))
                            Text("Logout")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundColor(.red)
                        }
                    })
                    Spacer().frame(width: 20)
                }
                
                Image("logo")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Spacer()
                
//                Picker(selection: $status, label: Text(""), content:  {
//                    Text("Today").tag(1)
//                    Text("Monthly").tag(2)
//                    Text("Total").tag(3)
//                })
//                .pickerStyle(.segmented)
//                .frame(width: UIScreen.main.bounds.width / 2)
                
                MidPickerView(items: $items, onItemSelected:{_ in} )
                Spacer().frame(height: 20)
                
                scrollView.id(items)
                Spacer()
                
            }
            .onChange(of: items) { newValue in
                for item in items {
                    if item.isSelected {
                        currentMode = StaticsMode(rawValue: item.id)!
                    }
                }
            }
        }
    }
    
    var scrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.reports, id: \.id) { reports in
                
                ReportCellView(report: reports, typeCell: $currentMode, indexCell: ((Int(reports.name) ?? 1) - 1) )
                    .onTapGesture {
                        if reports.name == "1" {
                            viewModel.container.appState[\.currentRoute] = .bookingCountView
                        } else if reports.name == "2" {
                            viewModel.container.appState[\.currentRoute] = .bookingSumView
                        } else if reports.name == "4" {
                            viewModel.container.appState[\.currentRoute] = .onBoarding
                        }
                        
                    }
                
            }.padding(.bottom)
        }.refreshable {
            viewModel.viewDidAppear()
        }
    }
    
    
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeView.ViewModel(container: .preview))
    }
}
#endif
