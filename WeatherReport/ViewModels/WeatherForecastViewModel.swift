//
//  WeatherForecastViewModel.swift
//  WeatherReport
//
//  Created by Jack on 6/26/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

class WeatherForecastListViewModel {
    private let forecastList: ForecastListModel
    
    init(forecastList: ForecastListModel) {
        self.forecastList = forecastList
    }
}

extension WeatherForecastListViewModel {
    var weatherListsData: [WeatherForecastViewModel] {
        return forecastList.list.map {
            WeatherForecastViewModel(forecastInfo: $0)
        }
    }
    
    var getsevenWeatherData: [WeatherForecastViewModel] {
        
        return Array(weatherListsData[0 ..< 8])
    }
    
    var weekdayWeather: [WeatherForecastViewModel] {
        let filterWeather = weatherListsData.filter { (forecastInfo) -> Bool in
            return forecastInfo.convertTime == 18
        }
        return filterWeather
    }
}

struct WeatherForecastViewModel {
    let forecastInfo: ForecastInfoModel
}

extension WeatherForecastViewModel {
    
    var convertTime: Int {
        return forecastInfo.forecastTimeDescription.convertDetailToDate.convertToHour
    }
    
    var convertToHourTime: String {
        return forecastInfo.forecastTimeDescription.convertDetailToDate.convertToHourTime
    }
    
    var weatherImageDisplayName: String {
        let weatherStatus = forecastInfo.forecastDescription[0].weatherStatus
        
        return weatherStatus.displayImageName
    }
    
    func minTemperature(with unit: Unit) -> String {
        let minTemperature = forecastInfo.forecastWeather.temperatureMin
        return unit == .celsius ? minTemperature.formatToCelsiusDegree : minTemperature.formatToFahrenheitDegree
    }
    
    func maxTemperature(with unit: Unit) -> String {
        let maxTemperature = forecastInfo.forecastWeather.temperatureMax
        return unit == .celsius ? maxTemperature.formatToCelsiusDegree : maxTemperature.formatToFahrenheitDegree
    }
    
    func rangeTemperature(with unit: Unit) -> String {
        let min = minTemperature(with: unit)
        let max = maxTemperature(with: unit)
        
        return "\(max)/\(min)"
    }
    
    func currentTemperature(with unit: Unit) -> String {
        let temperature = forecastInfo.forecastWeather.temperature
        return unit == .celsius ? temperature.formatToCelsiusDegree : temperature.formatToFahrenheitDegree
    }
}
