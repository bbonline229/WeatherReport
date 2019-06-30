//
//  TodayWeatherCell.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class TodayWeatherCell: UITableViewCell {
    
    private(set) var todayTemptureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "- -"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        return label
    }()
    
    private(set) var todayWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) var currentLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.backgroundColor = .specialGray
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    var weatherData: WeatherViewModel? {
        didSet {
            guard let weatherData = weatherData else { return }
            
            let currentTemperature = weatherData.currentTemperature(with: unit)
            let rangeTemperature = weatherData.rangeTemperature(with: unit)
            
            todayTemptureLabel.attributedText = setAttributedString(withAttr1: currentTemperature, attr2: rangeTemperature)
            
            todayWeatherImageView.image = UIImage(named: weatherData.weatherImageDisplayName)
            
            currentLocationLabel.addIconToLabel(imageName: "Icon_location", labelText: weatherData.currentLocation, bounds_x: -3, bounds_y: 0, boundsWidth: 20, boundsHeight: 20)
        }
    }
    
    var unit: Unit = .celsius
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setupUI() {
        contentView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        let weatherContainerView = UIView()
        
        contentView.addSubview(weatherContainerView)
        
        weatherContainerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 24))
        weatherContainerView.addSubview(todayTemptureLabel)
        weatherContainerView.addSubview(todayWeatherImageView)
        weatherContainerView.addSubview(currentLocationLabel)
        
        todayTemptureLabel.anchor(top: weatherContainerView.topAnchor, leading: weatherContainerView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        todayWeatherImageView.centerYAnchor.constraint(equalTo: weatherContainerView.centerYAnchor, constant: 0).isActive = true
        todayWeatherImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: weatherContainerView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0),size: CGSize(width: 140, height: 140))
        
        currentLocationLabel.centerXAnchor.constraint(equalTo: todayTemptureLabel.centerXAnchor).isActive = true
        currentLocationLabel.anchor(top: todayTemptureLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 120, height: 35))
    }
    
    private func setAttributedString(withAttr1 attr1: String, attr2: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: attr1)
        
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 19.0)]
        let mutableAttrString2 = NSMutableAttributedString(string: attr2,attributes: attrs)
        attributedString.append(mutableAttrString2)
        
        return attributedString
    }
}
