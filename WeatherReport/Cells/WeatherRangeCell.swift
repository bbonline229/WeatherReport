//
//  WeatherRangeCell.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class WeatherRangeCell: UITableViewCell {
    
    private let rangeVC = WeatherRangeVC()
    
    var unit: Unit = .celsius
    
    var forecastData: WeatherForecastListViewModel? {
        didSet {
            rangeVC.unit = unit
            rangeVC.forecastData = forecastData
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
        setupUI()
    }
    
    private func setup() {
       backgroundColor = .clear
    }
    
    private func setupUI() {
        contentView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        addSubview(rangeVC.view)
        
        rangeVC.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
