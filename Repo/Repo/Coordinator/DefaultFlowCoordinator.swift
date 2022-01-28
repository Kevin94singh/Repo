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

final class CountryFlowCoordinator: BaseCoordinator<NoDeepLink> {
    weak var flowDelegate: AppFlowDelegate?
    
    override func start(in window: UIWindow) {
        super.start(in: window)
        
        let viewController = CountryViewController(viewModel: CountryViewModel(dependencies: dependencies))
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        rootViewController = navigationController
        self.navigationController = navigationController
    }
}

extension CountryFlowCoordinator: CountryViewControllerDelegate {
    func countryViewControllerDelegateShowError() {
        let viewController = ErrorViewController(viewModel: NoViewModel())
        viewController.dismissTapped = { [weak self] in
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
}
