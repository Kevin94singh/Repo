//
//  TableHeaderView.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

import UIKit
import Stevia

final class TableHeaderView: UIView {
    
    let titleLabel = UILabel()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.initialize(title: nil)
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        self.initialize(title: title)
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        self.initialize(title: title)
    }
    
    private func initialize(title: String?) {
        self.sv(
            titleLabel
        )
        
        self.layout(
            10,
            |-20-titleLabel.centerInContainer()-|,
            >=8
        )
        
        if let title = title {
            titleLabel.text = title
        }
        self.backgroundColor = UIColor.clear
    }
}
