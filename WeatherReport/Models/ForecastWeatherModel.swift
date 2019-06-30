//
//  ForecaseWeatherModel.swift
//  WeatherReport
//
//  Created by Jack on 6/26/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

enum WeekOfDay: Int {
    case sun = 1
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    
    var displayName: String {
        switch self{
        case .sun:
            return "Sunday"
        case .mon:
            return "Monday"
        case .tue:
            return "Tuesday"
        case .wed:
            return "Wednesday"
        case .thu:
            return "Thursday"
        case .fri:
            return "Friday"
        default:
            return "Saturday"
        }
    }
}

struct ForecastListModel: Decodable {
    let list: [ForecastInfoModel]
}

struct ForecastInfoModel: Decodable {
    let forecastDescription: [ForecastWeatherDescriptionModel]
    let forecastWeather: ForecastWeatherModel
    let forecastTimeDescription: String

    private enum CodingKeys: String, CodingKey {
        case forecastDescription = "weather"
        case forecastWeather = "main"
        case forecastTimeDescription = "dt_txt"
    }
}

struct ForecastWeatherDescriptionModel: Decodable {
    
    let weatherStatus: WeatherStatus
    
    private enum CodingKeys: String, CodingKey {
        case weatherStatus = "main"
    }
}

struct ForecastWeatherModel: Decodable {
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
