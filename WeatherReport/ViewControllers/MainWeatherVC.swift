//
//  MainWeatherVC.swift
//  WeatherReport
//
//  Created by Jack on 6/24/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

protocol SettingWeatherDelegate: class {
    func updateWeatherSetting(vm: SettingViewModel)
}

class MainWeatherVC: UIViewController {
    
    enum WeatherComponent: Int, CaseIterable {
        case todayWeather = 0
        case rangeWeather
        case weekWeather
    }
    
    lazy private var weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy private var navigateButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(openSetting), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "Icon_setting"), for: .normal)
        return button
    }()
    
    private var weatherData: WeatherViewModel? {
        didSet {
            weatherTableView.reloadSections([WeatherComponent.todayWeather.rawValue], with: .none)
        }
    }
    
    private var forecaseData: WeatherForecastListViewModel? {
        didSet {
            weatherTableView.reloadSections([
                WeatherComponent.rangeWeather.rawValue,
                WeatherComponent.weekWeather.rawValue
            ], with: .none)
        }
    }
    
    private let weatherService = WeatherService()
    private let settingVM = SettingViewModel()

    private let weatherComponents = WeatherComponent.allCases
    
    private lazy var unit =  Unit(rawValue: settingVM.selectedUnit)!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupUI()
        
        requestWeatherData(with: settingVM.queryCity)
    }
    
    private func setup() {
        weatherTableView.bounces = false
        weatherTableView.register(TodayWeatherCell.self, forCellReuseIdentifier: "TodayWeatherCell")
        weatherTableView.register(WeekWeatherCell.self, forCellReuseIdentifier: "WeekWeatherCell")
        weatherTableView.register(WeatherRangeCell.self, forCellReuseIdentifier: "WeatherRangeCell")
        
        changeBackgroundColor()
    }
    
    private func setupUI() {
        let topView = UIView()
        view.addSubview(topView)
        topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 44))
        topView.addSubview(navigateButton)
        view.addSubview(weatherTableView)
        weatherTableView.anchor(top: topView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        navigateButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        navigateButton.anchor(top: nil, leading: nil, bottom: nil, trailing: topView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
    }
    
    private func requestWeatherData(with queryCity: String) {
        let todayQuery = [
            "q": queryCity,
            "appid": appID,
            "units": "metric"
        ]
        
        let todayWeatherURL = URL(string: baseURL)!.withQueries(todayQuery)!
        print("######1\(todayWeatherURL)")
        
        let resource = Resource<WeatherInfoModel>(url: todayWeatherURL)
        weatherService.load(resource: resource) { (weatherData) in
            guard let weatherData = weatherData else { return }
            self.weatherData = WeatherViewModel(weatherInfo: weatherData)
        }
        
        let forecastQuery = [
            "q": queryCity,
            "appid": appID,
            "units": "metric"
        ]
        
        let aurl = URL(string: forecaseURL)!.withQueries(forecastQuery)!
        print("######\(aurl)")
        
        let resource1 = Resource<ForecastListModel>(url: aurl)
        weatherService.load(resource: resource1) { (ttt) in
            guard let ttt = ttt else { return }
            
            self.forecaseData = WeatherForecastListViewModel(forecastList: ttt)
        }
    }
    
    @objc func openSetting() {
        let settingVC = SettingVC()
        settingVC.delegate = self
        let navSettingVC = UINavigationController(rootViewController: settingVC)
        present(navSettingVC, animated: true, completion: nil)
    }
    
    private func changeBackgroundColor() {
        let backgroundColor: UIColor = (settingVM.selectedWeatherTheme == 0) ? .skyBlue : .darkBlue
        view.backgroundColor = backgroundColor
    }
}

extension MainWeatherVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return weatherComponents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch weatherComponents[section] {
        case .todayWeather:
            return 1
        case .rangeWeather:
            return 1
        case .weekWeather:
            return forecaseData?.weekdayWeather.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch weatherComponents[indexPath.section] {
        case .todayWeather:
            let cell = weatherTableView.dequeueReusableCell(withIdentifier: "TodayWeatherCell", for: indexPath) as! TodayWeatherCell
            cell.unit = unit
            cell.weatherData = weatherData
            return cell
        case .rangeWeather:
            let cell = weatherTableView.dequeueReusableCell(withIdentifier: "WeatherRangeCell", for: indexPath) as! WeatherRangeCell
            cell.unit = unit
            cell.forecastData = forecaseData
            return cell
        case .weekWeather:
            let cell = weatherTableView.dequeueReusableCell(withIdentifier: "WeekWeatherCell", for: indexPath) as! WeekWeatherCell
            cell.unit = unit
            cell.forecastViewModel = forecaseData?.weekdayWeather[indexPath.row]
            cell.dayIndex = indexPath.row
            return cell
        }
    }
}

extension MainWeatherVC: SettingWeatherDelegate {
    func updateWeatherSetting(vm: SettingViewModel) {
        unit = Unit(rawValue: vm.selectedUnit)!
    
        requestWeatherData(with: vm.queryCity)
        changeBackgroundColor()
    }
}
