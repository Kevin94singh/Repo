//
//  AppFlowCoordinator.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import UIKit
import RxSwift

protocol AppFlowDelegate: AnyObject {
    func showDefaultFlow()
}

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
        
        self.showDefaultFlow()
    }
}

extension AppFlowCoordinator: AppFlowDelegate {
    func showDefaultFlow() {
        let defaultFlow = DefaultFlowCoordinator()
        self.addChild(defaultFlow)
        defaultFlow.start(in: window)
    }
}
