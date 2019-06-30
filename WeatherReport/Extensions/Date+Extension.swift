//
//  Date+Extension.swift
//  WeatherReport
//
//  Created by Jack on 6/26/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

extension Date {
    var convertToHourTime: String {
        let dateformatter = DateFormatter()
        let calendar = Calendar.current
        dateformatter.calendar = calendar
        dateformatter.dateFormat = "h a"
        dateformatter.timeZone = TimeZone(identifier: "UTC")
        return dateformatter.string(from: self)
    }
    
    var convertToDay: Int {
        let dateformatter = DateFormatter()
        let calendar = Calendar.current
        dateformatter.calendar = calendar
        dateformatter.dateFormat = "d"
        dateformatter.timeZone = TimeZone(identifier: "UTC")
        return Int(dateformatter.string(from: self))!
    }
    
    var convertToHour: Int {
        let dateformatter = DateFormatter()
        let calendar = Calendar.current
        dateformatter.calendar = calendar
        dateformatter.dateFormat = "HH"
        dateformatter.timeZone = TimeZone(identifier: "UTC")
        return Int(dateformatter.string(from: self))!
    }
}
