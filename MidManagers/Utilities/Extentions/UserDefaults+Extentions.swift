//
//  UserDefaults+Extentions.swift
//  MidManagers
//
//  Created by Khaled on 02/03/2024.
//

import Foundation

extension UserDefaults {
    
    private static let userMobileNumberKey = "UserMobileNumberKey"
    private static let biometricPermissionKey = "BiometricPermissionKey"
    
    
    // Save the user's mobile number to UserDefaults
    static func saveUserMobileNumber(_ mobileNumber: String) {
        standard.set(mobileNumber, forKey: userMobileNumberKey)
    }
    
    // Retrieve the user's mobile number from UserDefaults
    static func getUserMobileNumber() -> String? {
        return standard.string(forKey: userMobileNumberKey)
    }
    
    // Remove the user's mobile number from UserDefaults
    static func removeUserMobileNumber() {
        standard.removeObject(forKey: userMobileNumberKey)
    }
    
    // Save biometric permission
    static func saveBiometricPermission(_ allowed: Bool) {
        standard.set(allowed, forKey: biometricPermissionKey)
    }
    
    // Retrieve biometric permission
    static func getBiometricPermission() -> Bool {
        return standard.bool(forKey: biometricPermissionKey)
    }
    
    // Remove biometric permission
    static func removeBiometricPermission() {
        standard.removeObject(forKey: biometricPermissionKey)
    }
}
