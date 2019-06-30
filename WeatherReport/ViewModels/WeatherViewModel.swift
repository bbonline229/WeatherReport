//
//  weatherListViewModel.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

class WeatherViewModel {
    private let weatherInfo: WeatherInfoModel
    
    init(weatherInfo: WeatherInfoModel) {
        self.weatherInfo = weatherInfo
    }
}

extension WeatherViewModel {
    
    var currentLocation: String {
        return weatherInfo.cityName
    }
    
    var weatherImageDisplayName: String {
        let weatherStatus = weatherInfo.weatherDescription[0].weatherStatus
        
        return weatherStatus.displayImageName
    }
    
    func minTemperature(with unit: Unit) -> String {
        let minTemperature = weatherInfo.currentWeather.temperatureMin
        return unit == .celsius ? minTemperature.formatToCelsiusDegree : minTemperature.formatToFahrenheitDegree
    }
    
    func maxTemperature(with unit: Unit) -> String {
        let maxTemperature = weatherInfo.currentWeather.temperatureMax
        return unit == .celsius ? maxTemperature.formatToCelsiusDegree : maxTemperature.formatToFahrenheitDegree
    }
    
    func rangeTemperature(with unit: Unit) -> String {
        let min = minTemperature(with: unit)
        let max = maxTemperature(with: unit)
        
        return "\n最高\(max) / 最低\(min)"
    }
    
    func currentTemperature(with unit: Unit) -> String {
        let temperature = weatherInfo.currentWeather.temperature
        return unit == .celsius ? temperature.formatToCelsiusDegree : temperature.formatToFahrenheitDegree
    }
}
