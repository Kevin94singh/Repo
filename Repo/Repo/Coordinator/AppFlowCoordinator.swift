//
//  AppFlowCoordinator.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import UIKit
import RxSwift

final class AppFlowCoordinator: BaseCoordinator<NoDeepLink> {
    private var window: UIWindow!
    
    // MARK: - Dispose bag
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func start(in window: UIWindow) {
        super.start(in: window)
        self.window = window
        
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        
        window.rootViewController = vc
        rootViewController = vc
        
        self.showCountryFlow()
    }
}

extension AppFlowCoordinator: AppFlowDelegate {
    func showCountryFlow() {
        let countryFlow = CountryFlowCoordinator()
        self.addChild(countryFlow)
        countryFlow.start(in: window)
    }
}
