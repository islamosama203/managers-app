//
//  LoginView.swift
//  MidManagers
//
//  Created by Khaled Rashed on 10/12/2023.
//

import SwiftUI
import AVFAudio
import SwiftUI
import ActivityIndicatorView

struct LoginView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showingAlert = false
    @State var size = UIScreen.main.bounds.width / 2 - 100
    
    var body: some View {
        
        ZStack {
            content
            LoadingView(isVisible: $viewModel.showLoadingIndicator)
            
            if viewModel.showNoInternet {
                LoseConnectionInternetView(didTapRetry: NetworkUtility.shared.retryButtonPressed).frame(width: UIScreen.main.bounds.width)
            }
        }
        
        
        // alert when something went wrong with login
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(
                title: Text("MID Managers"),
                message: Text(viewModel.errorMessage),
                dismissButton: .destructive(Text("alrtBtnOK"))
            )
            
        }.disabled(viewModel.showLoadingIndicator)
        
    }
    
    
    var content: some View {
        
            VStack {
                ZStack {
                    Image("HeaderAuth")
                        .edgesIgnoringSafeArea(.all)
                    Image("logoRed")
                        .edgesIgnoringSafeArea(.all)
                }
                
                VStack {

                    TextField("phoneNumber", text: $viewModel.mobileNumber)
                        .onChange(of: viewModel.mobileNumber, perform: { newValue in
                            if newValue.count > 11 {
                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
                            }
                            viewModel.mobileNumber = String(newValue.prefix(11))
                            
                        })
                    
                        .textFieldStyle(XPrimaryTextField(systemImageString: "iphone"))
                        .font(.custom("Poppins-Medium", size: 16))
                        .keyboardType(.numberPad)
                        .frame(width: UIScreen.main.bounds.width - 35, height: 50)
                    
                    
                    Spacer().frame(height: 10)
                    SecureInputView("password".localized, text: $viewModel.password)
                        .onChange(of: viewModel.password, perform: { newValue in
                            if newValue.count > 10 {
                                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return }
                            }
                            viewModel.password = String(newValue.prefix(10))
                            
                        })
                        .textFieldStyle(XPrimaryTextField(systemImageString: "lock"))
                        .font(.custom("Poppins-Medium", size: 16))
                        .keyboardType(.alphabet)
                        .textContentType(.password)
                        .frame(width: UIScreen.main.bounds.width - 35, height: 50)
                    
                    Spacer().frame(height: 30)
                    
                    Button( action: {
                        
                        viewModel.loginUser(mobileNumber: viewModel.mobileNumber, password: viewModel.password)
                    }, label: {
                        Text("btnLogin")
                            .frame(width: UIScreen.main.bounds.width - 35, height: 50)
                            .font(.custom("Poppins-SemiBold", size: 16))
                    })
                    .containerShape(Rectangle())
                    .foregroundColor(.white)
                    .background(Color(.mainPurple))
                    .cornerRadius(5)
                    
                    
                    HStack {
                        Spacer()
                        Divider()
                            .frame(width: UIScreen.main.bounds.width / 3, height: 2)
                            .background(Color.gray)
                        Text("OR")
                            .frame(alignment: .center)
                            .font(.custom("Poppins-Medium", size: 14))
                        Divider()
                            .frame(width: UIScreen.main.bounds.width / 3, height: 2)
                            .background(Color.gray)
                        Spacer()
                    }
                    
                    // show the button in case we have oermition to use Biometric
                    if viewModel.showLoginViaBiometric {
                        Button(action: {
                            // login via biometric
                            UserDefaults.saveBiometricPermission(viewModel.biometricAllowed)
                            viewModel.authenticateWithBiometrics()
                        }, label: {
                            Text("Login using your biometric id")
                                .frame(width: UIScreen.main.bounds.width - 35, height: 50)
                                .font(.custom("Poppins-SemiBold", size: 14))
                        })
                            .foregroundColor(.white)
                            .background(Color("MainGreen"))
                            .cornerRadius(5)
                            .font(.system(size: 20))
                    } else  {
                        Toggle("Allow Biometric Login", isOn: $viewModel.biometricAllowed)
                            .frame(width: UIScreen.main.bounds.width / 1.7)
                            .opacity(viewModel.showLoginViaBiometric ? 0 : 1)
                    }
                    
                    
                }
                Spacer()
                
                
            }
            
            .navigationDestination(isPresented: $viewModel.navigateToHome) {
                HomeView(viewModel: .init(container: viewModel.container)).navigationBarBackButtonHidden(true) }
            
            
        

    }
}


// MARK: - Preview
#if DEBUG
#Preview {
    LoginView(viewModel: LoginView.ViewModel(container: .preview))
}
#endif
