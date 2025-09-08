//
//  UserSession.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import Foundation
import UIKit
import SwiftUI

struct User: Codable {
    var name: String
    var token: String
}

struct UserSession {
    
    static let shared: UserSession = UserSession()
    
    var sceneDelegate: SceneDelegate? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
        return delegate
    }
    
    static  var user: User? {
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "user")
            }
        }
        
        get {
            if let data = UserDefaults.standard.value(forKey: "user") as? Data {
                if let user = try? JSONDecoder().decode(User.self, from: data) {
                    return user
                }
            }
            return nil
        }
    }
    
    
    
    var isUserLogedIn: Bool {
        UserSession.user != nil
    }
    
    
    static func logout() {
        // remove all userDefaults here
        UserDefaults.standard.removeObject(forKey: "user")
        DispatchQueue.main.async {
            let scene = UserSession.shared.sceneDelegate
            let environment = AppEnvironment.bootstrap()
            let loginView = LoginView(viewModel:
                                        LoginView.ViewModel(container: environment.container))
            scene?.window?.rootViewController = UIHostingController(rootView: loginView)
        }
    }
    
    static func resetApp() {
        UserDefaults.standard.removeObject(forKey: "user")
            DispatchQueue.main.async {
                let scene = UserSession.shared.sceneDelegate
                let environment = AppEnvironment.bootstrap()
                let contentView = ContentView(container: environment.container)
                scene?.window?.rootViewController = UIHostingController(rootView: contentView)
            }
        }
    
    
}
