//
//  ViewStyle.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

import UIKit

struct ViewStyle {
    static func roundedWithShadow(view: UIView) {
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.shadowColor
        view.layer.cornerRadius = 10
    }
}
