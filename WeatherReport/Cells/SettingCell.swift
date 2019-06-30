//
//  SettingCell.swift
//  WeatherReport
//
//  Created by Jack on 6/27/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    var settingTitle: String? {
        didSet {
            textLabel?.text = settingTitle
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
