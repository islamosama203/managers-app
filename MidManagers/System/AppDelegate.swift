//
//  AppDelegate.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 23.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import UIKit
import Combine
//import FirebaseCore
//import Firebase
import UserNotifications
import IQKeyboardManagerSwift
//import netfox

typealias NotificationPayload = [AnyHashable: Any]
typealias FetchCompletion = (UIBackgroundFetchResult) -> Void

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

//    lazy var systemEventsHandler: SystemEventsHandler? = {
//        self.systemEventsHandler(UIApplication.shared)
//    }()
//    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true

        // untill creat a firebase for the app managers
        //        FirebaseApp.configure()

//        #if DEBUG
//        NFX.sharedInstance().start()
//        #endif

        // setting up cloud messaging
       // Messaging.messaging().delegate = self

        // setting up notifications
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: { _, _ in })
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
//        application.registerForRemoteNotifications()
//
//        if launchOptions != nil {
//            let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification]
//            if userInfo != nil {
//                // Perform action here
//                print("0101000000000000000")
//            }
//        }

        return true
    }



    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: NotificationPayload,
                     fetchCompletionHandler completionHandler: @escaping FetchCompletion) {


        // What to do with Notifications
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//
//        systemEventsHandler?.appDidReceiveRemoteNotification(payload: userInfo, fetchCompletion: completionHandler)
    }

//    private func systemEventsHandler(_ application: UIApplication) -> SystemEventsHandler? {
//        return sceneDelegate(application)?.systemEventsHandler
//    }

    private func sceneDelegate(_ application: UIApplication) -> SceneDelegate? {
        //        return application.windows
        return UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .compactMap({ $0.windowScene?.delegate as? SceneDelegate })
            .first
    }
}

// Cloud Messaging...
//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//
//        let deviceToken: [String: String] = ["token": fcmToken ?? ""]
//        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
//        // what!!
//        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: deviceToken)
//        print("Device token: ", deviceToken) // This token can be used for testing notifications on FCM
//    }
//}

// User Notifications...
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    // Receive displayed notifications for iOS 10 devices.
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification) async
//        -> UNNotificationPresentationOptions {
//        let userInfo = notification.request.content.userInfo
//
//        // With swizzling disabled you must let Messaging know about the message, for Analytics
//        // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//        // ...
//
//        // Print full message.
//        print(userInfo)
//
//        // Change this to your preferred presentation option
//        return [[.banner, .badge, .sound]]
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse) async {
//        let userInfo = response.notification.request.content.userInfo
//
//        // ...
//
//        // With swizzling disabled you must let Messaging know about the message, for Analytics
//        // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//        // Print full message.
//        print(userInfo)
//    }
//
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        Messaging.messaging().apnsToken = deviceToken
//        systemEventsHandler?.handlePushRegistration(result: .success(deviceToken))
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        systemEventsHandler?.handlePushRegistration(result: .failure(error))
//    }
//
//}
