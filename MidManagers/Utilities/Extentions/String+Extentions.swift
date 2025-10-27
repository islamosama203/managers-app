//
//  String+Extentions.swift
//  MidTakseet
//
//  Created by Ehab Muhammed on 10/02/2022.
//

import Foundation

extension String {


    var locale: String {
        return NSLocalizedString(self, bundle: .main, comment: "")
    }

    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public var replacedAr2En: String {
        var str = self
        let map = [
            "٠": "0",
            "١": "1",
            "٢": "2",
            "٣": "3",
            "٤": "4",
            "٥": "5",
            "٦": "6",
            "٧": "7",
            "٨": "8",
            "٩": "9",
            "٫": ".",
            "+2": "",
            "+٢": ""
        ]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }

    func currencyStyle() -> String {
        // print("currString: \(avalAmount)")
        let formatter = NumberFormatter()
        //formatter.maximumSignificantDigits = 2
        formatter.locale = Locale(identifier: "eg_EG")// Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currencyAccounting
        //formatter.minimumFractionDigits = (avalAmount.contains(".00")) ? 0 : 2
        formatter.maximumFractionDigits = 2
        let val: NSNumber = self.trimmed.toDouble as NSNumber
        //  print("currStyle: \(String(describing: val))")
        if var formattedTipAmount = formatter.string(from: val) {
            print("currformat: \(formattedTipAmount)")
//            formattedTipAmount = formattedTipAmount.replacingOccurrences(of: "*", with: "").trimmed
//            formattedTipAmount = formattedTipAmount.replacingOccurrences(of: "¤", with: "").trimmed
            formattedTipAmount = formattedTipAmount.replacingOccurrences(of: "EGP", with: "").trimmed
            formattedTipAmount = formattedTipAmount.replacingOccurrences(of: ".00", with: "").trimmed
            return "\(formattedTipAmount)".replacedAr2En
        } else {
            return "100"
        }

    }
    
    func formatPoints(from: Int) -> String {

        let number = Double(from)
        let billion = number / 1_000_000_000
        let million = number / 1_000_000
        let thousand = number / 1000
        
        if billion >= 1.0 {
            return "\(round(billion * 10) / 10)B"
        } else if million >= 1.0 {
            return "\(round(million * 10) / 10)M"
        } else if thousand >= 1.0 {
            return "\(round(thousand * 10) / 10)K"
        } else {
            return "\(Int(number))"
        }
    }
    
    
    

    public var toInt: Int {
        var val = self.trimmed
        val = val.replacingOccurrences(of: ",", with: "")
        val = val.replacingOccurrences(of: "LE", with: "")
        return Int(val) ?? 0
    }

    public var toDouble: Double {

        var newVal = self.trimmed.replacingOccurrences(of: ",", with: "")
        newVal = newVal.replacingOccurrences(of: "LE", with: "")

        return Double(newVal) ?? 0.0
    }

    subscript(i: Int) -> String {
        print("subscript: \(self.description)  count:\(self.count)")
        if self.count > 1 {
            return String(self[index(startIndex, offsetBy: i)])
        } else {
            return ""
        }

    }
}

// Add EGP
extension String {

    var asEGPPrice: String {
        return LanguageManager.shared.currentLanguage.rawValue == "ar" ? self + " جنيه" : "EGP " + self
    }
}

// Localize
extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
  
  func localized(_ args: [CVarArg]) -> String {
    return localized(args)
  }
  
  func localized(_ args: CVarArg...) -> String {
    return String(format: localized, args)
  }
}


class CurrencyFormatter: NSObject {
    static func stringFromNumber(
        _ number: NSNumber, abbreviateThousands: Bool = true, abbreviateMillions: Bool = true
    ) -> String? {
        if abbreviateMillions && number.floatValue > 1000000 {
            let millions = number.floatValue / 1000000
            return String(format: "%.01fM", millions)
        } else if abbreviateThousands && number.floatValue > 1000 {
            let thousands = number.floatValue / 1000
            return String(format: "%.01fK", thousands)
        }
        return numberFormatter.string(from: number)
    }

    static func stringFrom(float: Float, abbreviateThousands: Bool = true) -> String? {
        return self.stringFromNumber(NSNumber(value: float), abbreviateThousands: abbreviateThousands)
    }

    static func stringFrom(integer: Int, abbreviateThousands: Bool = true) -> String? {
        return self.stringFromNumber(NSNumber(value: integer), abbreviateThousands: abbreviateThousands)
    }

    static let numberFormatter: NumberFormatter = {
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .currency
        numFormatter.usesGroupingSeparator = true
        numFormatter.locale = Locale(identifier: "en_US")
        return numFormatter
    }()

}
