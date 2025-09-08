//
//  Date+Extention.swift
//  MidTakseet
//
//  Created by Ehab Muhammed on 10/02/2022.
//

import Foundation

extension Date {
    
    static func calcBDate(day:Int,month:Int,year:Int) ->Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        var xyear = year
        if year < 21 {
            xyear = 2000 + year
        } else {
            xyear = 1900 + year
        }
        return formatter.date(from: "\(xyear)/\(month)/\(day)")!
    }
    
    func calctAge(yyyy: String,MM: String,dd: String) -> Int {
        
        let birthDate = Date.calcBDate(day: Int(dd)!, month: Int(MM)!, year: Int(yyyy)!)
        let today = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day], from: birthDate, to: today)
        
        let ageYears = components.year
       // let ageMonths = components.month
       // let ageDays = components.day
        print("bd: \(birthDate) td: \(today)")
        return ageYears!
    }
    
    
    
}


