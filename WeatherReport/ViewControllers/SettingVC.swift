//
//  SettingVC.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

enum SettingComponent: Int, CaseIterable {
    case temperatureUnit = 0
    case weatherTheme
    case cityData
}

class SettingVC: UIViewController {
    
    lazy private var settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private var settingVM = SettingViewModel()
    private var settingComponent = SettingComponent.allCases
    
    private lazy var selectedUnitIndex = settingVM.selectedUnit
    private lazy var selectedThemeIndex = settingVM.selectedWeatherTheme
    private lazy var selectedCityIndex = settingVM.selectedCity
    
    weak var delegate: SettingWeatherDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupUI()
    }
    
    private func setup() {
        settingTableView.bounces = false
        settingTableView.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
        
        navigationItem.title = "設置"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "儲存", style: .done, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancel))
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        
        settingVM.unitsStatus[selectedUnitIndex] = true
        settingVM.weatherthemesStatus[selectedThemeIndex] = true
        settingVM.cityDataStatus[selectedCityIndex] = true
    }
    
    private func setupUI() {
        view.addSubview(settingTableView)
        settingTableView.fillSuperview()
    }
    
    @objc private func save() {
        settingVM.selectedUnit = selectedUnitIndex
        settingVM.selectedWeatherTheme = selectedThemeIndex
        settingVM.selectedCity = selectedCityIndex
    
        delegate?.updateWeatherSetting(vm: settingVM)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingComponent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let component = settingComponent[section]
        
        switch component {
        case .temperatureUnit:
            return settingVM.units.count
        case .weatherTheme:
            return settingVM.weatherThemes.count
        default:
            return settingVM.cityDatas.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let component = settingComponent[section]
        
        switch component {
        case .temperatureUnit:
            return "溫度設定"
        case .weatherTheme:
            return "主題設定"
        case .cityData:
            return "選擇地區"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        let component = settingComponent[indexPath.section]
        switch component {
        case .temperatureUnit:
            cell.settingTitle = settingVM.units[indexPath.row].displayName
            if settingVM.unitsStatus[indexPath.row] {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .weatherTheme:
            cell.settingTitle = settingVM.weatherThemes[indexPath.row].displayName
            if settingVM.weatherthemesStatus[indexPath.row] {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .cityData:
            cell.settingTitle = settingVM.cityDatas[indexPath.row]
            if settingVM.cityDataStatus[indexPath.row] {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let component = settingComponent[indexPath.section]
        
        switch component {
        case .temperatureUnit:
            settingVM.unitsStatus = settingVM.unitsStatus.map {_ in
                return false
            }
            
            settingVM.unitsStatus[indexPath.row] = !settingVM.unitsStatus[indexPath.row]
            selectedUnitIndex = indexPath.row
            
            tableView.reloadSections([
                SettingComponent.temperatureUnit.rawValue
            ], with: .none)
            
        case .weatherTheme:
            settingVM.weatherthemesStatus = settingVM.weatherthemesStatus.map {_ in
                return false
            }
            
            settingVM.weatherthemesStatus[indexPath.row] = !settingVM.weatherthemesStatus[indexPath.row]
            selectedThemeIndex = indexPath.row
            
            tableView.reloadSections([
                SettingComponent.weatherTheme.rawValue
            ], with: .none)
        default:
            settingVM.cityDataStatus = settingVM.cityDataStatus.map({ (_) in
                return false
            })
            
            settingVM.cityDataStatus[indexPath.row] = !settingVM.cityDataStatus[indexPath.row]
            selectedCityIndex = indexPath.row
            tableView.reloadSections([
                SettingComponent.cityData.rawValue
            ], with: .none)
        }
    }
    
}
