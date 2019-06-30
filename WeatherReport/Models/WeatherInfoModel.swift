//
//  CurrentWeatherModel.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

enum WeatherStatus: String, Decodable {
    
    case cloud = "Clouds"
    case sunny = "Clear"
    case snow = "Snow"
    case rain = "Rain"
    case thunderStorm = "Thunderstorm"
    
    var displayImageName: String {
        switch self {
        case .cloud:
            return "Icon_cloudy"
        case .sunny:
            return "Icon_sunny"
        case .snow:
            return "Icon_snowy"
        case .rain:
            return "Icon_rainy"
        case .thunderStorm:
            return "Icon_stormy"
        }
    }
}

struct WeatherInfoModel: Decodable {
    
    let weatherDescription: [WeatherDescriptionModel]
    var currentWeather: TemperatureModel
    var cityName: String
    
    private enum CodingKeys: String, CodingKey {
        case weatherDescription = "weather"
        case currentWeather = "main"
        case cityName = "name"
    }
}

struct WeatherDescriptionModel: Decodable {
    
    let weatherStatus: WeatherStatus
    
    private enum CodingKeys: String, CodingKey {
        case weatherStatus = "main"
    }
}

struct TemperatureModel: Decodable {
    
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
