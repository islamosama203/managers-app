//
//  LoginViewModel.swift
//  MidManagers
//
//  Created by Khaled Rashed on 10/12/2023.
//

import SwiftUI
import AVFAudio
import ActivityIndicatorView
import LocalAuthentication

extension LoginView {

    class ViewModel: ObservableObject {

        
        @Published var mobileNumber = "" // "01666666666" "admin"
        @Published var password = "" // "Mid@1234" "123"
        @Published var biometricResult = ""
        @Published var showLoginViaBiometric = false
        @Published var biometricAllowed = UserDefaults.getBiometricPermission()
        @Published var navigateToHome = false
        @Published var showLoadingIndicator: Bool = false
        @Published var size = UIScreen.main.bounds.width / 2 - 100
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
                .handleEvents(receiveOutput: {
                    value in
                    print(value)
                })
                .weakAssign(to: \.showNoInternet, on: self)
                .store(in: cancelBag)
            
            showLoginViaBiometric = UserDefaults.getBiometricPermission()
        }

        func loginUser(mobileNumber: String, password: String) {
            guard NetworkUtility.shared.isConnected(appState: &appState,
                onRetry: {
                self.loginUser(mobileNumber: mobileNumber, password: password)
                }
            ) else { return }
            // the user didn't fill the field to username or pass
            if mobileNumber == "" || password == ""  {
                    self.showingAlert = true
                    self.errorMessage = "Please fill all fields"
                // if the user fill the data
            } else  {
                self.showLoadingIndicator = true
                container.services.loginService.login(mobileNumber: mobileNumber, password: password)
                
                    .sink { result in
                        if let error =  result.error {
                            self.errorMessage = error.localizedDescription
                            self.showingAlert = true
                            self.showLoadingIndicator = false
                        }
                    }
            receiveValue: { loginResponse in
                self.showLoadingIndicator = false
                if loginResponse.status {
                    print("Login success 🎉")
                    print("Data is ", loginResponse.data ?? "login Response data faild!")
                    
                    UserSession.user = User(name: "user", token: loginResponse.data ?? "")
                    if self.biometricAllowed {
                        if self.mobileNumber != "" && self.password != "" {
                            KeychainService.savePassword(token: self.password)
                            UserDefaults.saveUserMobileNumber(self.mobileNumber)
                            // Save biometric permission
                            UserDefaults.saveBiometricPermission(self.biometricAllowed)
                        }
                        
                    }
//                    self.container.appState[\.currentRoute] = .root
                    self.navigateToHome = true
                    UserSession.resetApp()
                    UserSession.user = User(name: "user", token: loginResponse.data ?? "")

                    
                } else {
                    self.errorMessage = loginResponse.messege
                    self.showingAlert = true
                    print("Login Failed! 😢")
                }
            }.store(in: cancelBag)
            }
        }
        
        func authenticateWithBiometrics() {
            let context = LAContext()

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate with biometrics") { (success, error) in
                    DispatchQueue.main.async {
                        if success {
                            self.biometricResult = "Biometric authentication succeeded"
                            // Handle successful authentication
                            if let userPassword = KeychainService.loadPassword(),
                               let userMobile = UserDefaults.getUserMobileNumber() {
                                self.loginUser(mobileNumber: userMobile, password: userPassword)
                            } else {
                                self.errorMessage = "No saved credentials found."
                                self.showingAlert = true
                            }
                        } else {
                            // Handle authentication failure
                            if let error = error {
                                self.biometricResult = "Biometric authentication failed: \(error.localizedDescription)"
                            } else {
                                self.biometricResult = "Biometric authentication failed"
                            }
                            self.errorMessage = self.biometricResult
                            self.showingAlert = true
                            print("Biometric authentication failed! 😢")
                        }
                    }
                    // end of DispatchQueue
                }
            } else {
                self.biometricResult = "Biometric authentication not available"
                // Handle case where biometric authentication is not available
                self.errorMessage = self.biometricResult
                self.showingAlert = true
            }
        }
        
        
        func textFieldLimit(text: inout String, characterLimit: Int) {
            
            if text.count > characterLimit {
                text = String(text.prefix(characterLimit))
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { return } }
        }
        
    }
}

