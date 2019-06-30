//
//  SettingViewModel.swift
//  WeatherReport
//
//  Created by Jack on 6/26/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

enum Unit: Int, CaseIterable {
    case celsius = 0
    case fahrenheit
    
    var displayName: String {
        switch self {
        case .celsius:
            return "攝氏"
        default:
            return "華氏"
        }
    }
}

enum WeatherTheme: Int, CaseIterable {
    case morning = 0
    case night
    //case automatic
    
    var displayName: String {
        switch self {
        case .morning:
            return "日間主題"
        case .night:
            return "夜間主題"
        }
    }
}

class SettingViewModel {
    let units = Unit.allCases
    let weatherThemes = WeatherTheme.allCases
    let cityDatas = CityData.allCitys
    
    
    lazy var unitsStatus = [Bool](repeating: false, count: units.count)
    lazy var weatherthemesStatus = [Bool](repeating: false, count: weatherThemes.count)
    lazy var cityDataStatus = [Bool](repeating: false, count: cityDatas.count)
    
    lazy private var storedCity = CityData.allCitys[selectedCity]
    
    lazy var queryCity = CityData.allCityAlias[storedCity] ?? "Taipei,Tw"
    lazy var queryUnit = (selectedUnit == 0) ? "metric" : "imperial"
}

extension SettingViewModel {
    var selectedUnit: Int {
        get {
            let unitValue = UserDefaults.standard.value(forKey: "unit") as? Int ?? 0
            
            return unitValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "unit")
        }
    }
    
    var selectedWeatherTheme: Int {
        get {
            let themeValue = UserDefaults.standard.value(forKey: "theme") as? Int ?? 0
            
            return themeValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "theme")
        }
    }
    
    var selectedCity: Int {
        get {
            let cityValue = UserDefaults.standard.value(forKey: "city") as? Int ?? 0
            
            return cityValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "city")
        }
    }
}
