//
//  AppStyle+.swift
//  Repo
//
//  Created by Kevin Singh on 15/11/2020.
//

import UIKit

extension Q.AppStyle {
    
    static var repoApp: Q.AppStyle {
        return Q.AppStyle(
            backgroundColor: .white,
            preferredStatusBarStyle: .default,
            attributesForStyle: { $0.repoAppAttributes }
        )
    }
}

private extension Q.AppStyle.TextStyle {
    
    var repoAppAttributes: Q.AppStyle.TextAttributes {
        switch self {
        case .navigationBar:
            return Q.AppStyle.TextAttributes(font: UIFont.systemFont(ofSize: 18, weight: .bold), color: .black, backgroundColor: .white)
        case .tabBar:
            return Q.AppStyle.TextAttributes(font: UIFont.systemFont(ofSize: 18), color: .white, backgroundColor: .green)
        }
    }
}
