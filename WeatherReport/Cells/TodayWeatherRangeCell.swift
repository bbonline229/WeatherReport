//
//  TodayWeatherRangeCell.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class TodayWeatherRangeCell: UICollectionViewCell {
    
    private(set) var timeRangeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
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
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var forecastInfo: WeatherForecastViewModel? {
        didSet {
            guard let forecastInfo = forecastInfo else { return }
            
            dayTempertureLabel.text = forecastInfo.currentTemperature(with: unit)
            timeRangeLabel.text = "\(forecastInfo.convertToHourTime)"
            weatherImageView.image = UIImage(named: forecastInfo.weatherImageDisplayName)
        }
    }
    
    var unit: Unit = .celsius
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [weatherImageView, dayTempertureLabel, timeRangeLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
