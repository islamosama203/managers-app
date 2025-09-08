//
//  Helper.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import UIKit
import SwiftUI

class Helper: NSObject {
    
    class func deviceData() {
        let heightScreen = UIScreen.main.bounds.height
        let device = UIDevice()
        print("heightScreen: \(heightScreen) \n deviceName: \(device.name) ** \(device.model)")
    }
    
    class func AppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }else{return "1.0.1"}
    }
    
    class func OSVersion() -> String {
        let systemVersion = ProcessInfo.processInfo.operatingSystemVersion
        return "\(systemVersion.majorVersion).\(systemVersion.minorVersion).\(systemVersion.patchVersion)"
        
    }
    
    
    class func convertImageToBase64(_ image: UIImage) -> String {
        let imageData: Data = image.jpegData(compressionQuality: 0.4)! as Data
        return imageData.base64EncodedString()
        
    }
    
    
    
    class func convertBase64ToImage(_ str: String?) -> UIImage {
        guard let data = Data(base64Encoded: str ?? "") else {
            print("image 4 convert is nil")
            return UIImage()
        }
        return  UIImage(data: data) ?? UIImage(named: "AppIcon")!
    }
    
    
    
}
