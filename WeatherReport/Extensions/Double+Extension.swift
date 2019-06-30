//
//  Double+Extension.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

extension Double {    
    var formatToCelsiusDegree: String {
        return String(format: "%.0f°c", self)
    }
    
    var formatToFahrenheitDegree: String {
        let fahrenheitDegree = (self * 9 / 5) + 32
        return String(format: "%.0f°f", fahrenheitDegree)
    }
}
