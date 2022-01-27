//
//  LabelStyle.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

import UIKit

struct LabelStyle {
    static func regular12LeftBlack80(label: UILabel) {
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black80
        label.textAlignment = .left
    }
    
    static func regular12Right(label: UILabel) {
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
    }
    
    static func regular14Black(label: UILabel) {
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
    }
    
    static func bold24Center(label: UILabel) {
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    static func regular16Center(label: UILabel) {
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black80
        label.numberOfLines = 0
        label.textAlignment = .center
    }
}
