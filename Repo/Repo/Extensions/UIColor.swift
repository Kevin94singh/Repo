//
//  UIColor+.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

import UIKit

extension UIColor {
    static let shadowColor = UIColor("#2A3039").withAlphaComponent(0.31).cgColor
    static let black80 = UIColor.black.withAlphaComponent(0.8)
    
    convenience init(_ hexString: String) {
        var hexString = hexString
        
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        }
        
        var rgbValue: UInt64 = 0
        
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
