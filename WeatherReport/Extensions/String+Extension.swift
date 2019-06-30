//
//  String+Extension.swift
//  WeatherReport
//
//  Created by Jack on 6/26/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

extension String {
    var convertDetailToDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.date(from: self)!
    }
}
