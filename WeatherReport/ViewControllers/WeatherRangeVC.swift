//
//  WeatherCollectionViewVC.swift
//  WeatherReport
//
//  Created by Jack on 6/25/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class WeatherRangeVC: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    var forecastData: WeatherForecastListViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var unit: Unit = .celsius
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupUI()
    }
    
    private func setup() {
        collectionView.register(TodayWeatherRangeCell.self, forCellWithReuseIdentifier: "TodayWeatherRangeCell")
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
}

extension WeatherRangeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastData?.getsevenWeatherData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayWeatherRangeCell", for: indexPath) as! TodayWeatherRangeCell
        let forecastInfo = forecastData?.getsevenWeatherData[indexPath.row]
        cell.unit = unit
        cell.forecastInfo = forecastInfo
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 5
        return CGSize(width: width, height: width * 1.5)
    }
}
