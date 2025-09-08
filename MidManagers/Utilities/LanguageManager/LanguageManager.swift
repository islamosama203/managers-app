//
//  LanguageManager.swift
//  MidManagers
//
//  Created by Khaled Rashed on 27/03/2023.
//

import Foundation
import UIKit

class LanguageManager {
    
    static let shared: LanguageManager = LanguageManager()
    var currentLanguage: Languages {
        get {
            
            guard let currentLang = UserDefaults.standard.string(forKey: "selectedLanguage") else {
               // let languagePrefix = Locale.preferredLanguages[0]
               // fatalError("Did you set the default language for the app ?")
                return Languages(rawValue: Locale.preferredLanguages[0]) ?? .en
            }
            return Languages(rawValue: currentLang)!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedLanguage")
        }
    }
    

    
    var isRightToLeft: Bool {
        get {
            let lang = LanguageManager.shared.currentLanguage.rawValue
            return lang.contains("ar") || lang.contains("he") || lang.contains("ur") || lang.contains("fa")
        }
    }
 
   
}

enum Languages:String {
    case ar,en,nl,ja,ko,vi,ru,sv,fr,es,pt,it,de,da,fi,nb,tr,el,id,ms,th,hi,hu,pl,cs,sk,uk,hr,ca,ro,he
    case enGB = "en-GB"
    case enAU = "en-AU"
    case enCA = "en-CA"
    case enIN = "en-IN"
    case frCA = "fr-CA"
    case esMX = "es-MX"
    case ptBR = "pt-BR"
    case zhHans = "zh-Hans"
    case zhHant = "zh-Hant"
    case zhHK = "zh-HK"
}
