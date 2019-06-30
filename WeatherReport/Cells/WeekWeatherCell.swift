//
//  WeekWeatherCell.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class WeekWeatherCell: UITableViewCell {
    
    private(set) var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private(set) var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon_sunny")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) var dayTempertureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    var forecastViewModel: WeatherForecastViewModel? {
        didSet {
            guard let forecastViewModel = forecastViewModel else { return }
            
            dayTempertureLabel.text = forecastViewModel.rangeTemperature(with: unit)
            weatherImageView.image = UIImage(named: forecastViewModel.weatherImageDisplayName)
        }
    }
    
    var dayIndex: Int! {
        didSet {
            let today = Calendar.current.component(.weekday, from: Date())
            let number = (dayIndex + today) % 7 + 1
            
            if dayIndex == 0 {
                dayLabel.text = "Tomorrow"
            } else {
                dayLabel.text = WeekOfDay(rawValue: number)!.displayName
            }
        }
    }
    
    var unit: Unit = .celsius

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupUI()
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupUI() {
        let weatherContainerView = UIView()
        contentView.addSubview(weatherContainerView)
        
        weatherContainerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24), size: CGSize(width: 0, height: 40))
        weatherContainerView.addSubview(dayLabel)
        weatherContainerView.addSubview(weatherImageView)
        weatherContainerView.addSubview(dayTempertureLabel)
        
        dayLabel.centerYAnchor.constraint(equalTo: weatherContainerView.centerYAnchor, constant: 0).isActive = true
        dayLabel.anchor(top: nil, leading: weatherContainerView.leadingAnchor, bottom: nil, trailing: nil)
        
        dayTempertureLabel.centerYAnchor.constraint(equalTo: weatherContainerView.centerYAnchor, constant: 0).isActive = true
        dayTempertureLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: weatherContainerView.trailingAnchor)
        
        weatherImageView.centerYAnchor.constraint(equalTo: weatherContainerView.centerYAnchor, constant: 0).isActive = true
        weatherImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: dayTempertureLabel.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), size: CGSize(width: 30, height: 30))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
