//
//  UILabel+Extension.swift
//  WeatherReport
//
//  Created by Jack on 7/1/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit

extension UILabel {
    func addIconToLabel(imageName: String, labelText: String, bounds_x: Double, bounds_y: Double, boundsWidth: Double, boundsHeight: Double) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        let rect = CGRect(x: bounds_x, y: bounds_y, width: boundsWidth, height: boundsHeight)
        attachment.bounds = rect
        let attachmentStr = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: "")
        string.append(attachmentStr)
        let string2 = NSMutableAttributedString(string: labelText)
        string.append(string2)
        self.attributedText = string
    }
}
