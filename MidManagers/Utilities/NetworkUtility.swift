//
//  NetworkUtility.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import Foundation
import SystemConfiguration

class NetworkUtility: ObservableObject {
    

    @Published var retryButtonPressed: (() -> ()) = {}
    
    static let shared = NetworkUtility()
    private init() { }
    
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    
    
    func isConnected(appState: inout  Store<AppState>, onRetry: (() -> ())?) -> Bool {
        
        if !isInternetAvailable() {
            appState[\.showNoInternet] = true
            retryButtonPressed = {
                onRetry?()
            }
            return false
        } else {
            appState[\.showNoInternet] = false
            return true
        }
        
    }
    
}


