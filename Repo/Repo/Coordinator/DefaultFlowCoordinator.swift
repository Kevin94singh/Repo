//
//  DefaultFlowCoordinator.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import UIKit

protocol UserFlowDelegate: AnyObject {
    func goToApp()
}

final class DefaultFlowCoordinator: BaseCoordinator<NoDeepLink> {
    weak var flowDelegate: AppFlowDelegate?
    
    override func start(in window: UIWindow) {
        super.start(in: window)
        
        let countryVC = CountryViewController(viewModel: CountryViewModel(dependencies: dependencies))
        let navigationController = UINavigationController(rootViewController: countryVC)
        
        window.rootViewController = navigationController
        rootViewController = navigationController
        self.navigationController = navigationController
    }
}
