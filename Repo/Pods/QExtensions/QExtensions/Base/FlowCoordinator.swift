//
//  FlowCoordinator.swift
//  QExtensions
//
//  Created by Tomas Holicky on 25/09/2019.
//  Copyright © 2019 Qusion. All rights reserved.
//

import UIKit
import os.log

extension QBase {
    
    /**
     Starts with one of `start()` methods and ends with `stop()`.
     
     All start methods are supposed to be overriden and property `rootViewController` must be set in the end of the overriden implementation to avoid memory leaks.
     Don't forget to call super.start().
     */
    
    /// Handles view controllers connections and flow
    open class FlowCoordinator<DeepLinkType>: NSObject, UINavigationControllerDelegate {
        
        /// Reference to the navigation controller used within the flow
        public weak var navigationController: UINavigationController?
        
        /// First VC of the flow. Must be set when FC starts.
        public weak var rootViewController: UIViewController!
        
        /// Parent coordinator
        public weak var parentCoordinator: FlowCoordinator?
        
        /// Array of child coordinators
        public var childCoordinators = [FlowCoordinator]()
        
        /// Currently active coordinator
        public weak var activeChild: FlowCoordinator?
        
        // MARK: - Lifecycle
        
        /// Just start and return rootViewController. Object calling this method will connect returned view controller to the flow.
        @discardableResult open func start() -> UIViewController {
            return UIViewController()
        }
        
        /// Start in window. Window's root VC is supposed to be set.
        open func start(in window: UIWindow) {}
        
        /// Start within existing navigation controller.
        open func start(with navigationController: UINavigationController) {
            self.navigationController = navigationController
            navigationController.delegate = self
        }
        
        /// Start by presenting from given VC. This method must be overriden by subclass.
        open func start(from viewController: UIViewController) {}
        
        /// Clean up. Must be called when FC finished the flow to avoid memory leaks and unexpcted behavior.
        open func stop(animated: Bool = false) {
            
            // stop all children
            childCoordinators.forEach { $0.stop(animated: animated) }
            
            // dismiss all VCs presented from root or nav
            if rootViewController.presentedViewController != nil {
                rootViewController.dismiss(animated: animated)
            }
            
            // dismiss when root was presented
            rootViewController.presentingViewController?.dismiss(animated: animated)
            
            // pop all view controllers when started within navigation controller
            if let index = navigationController?.viewControllers.firstIndex(of: rootViewController) {
                // VCs to be removed from navigation stack
                let toRemoveViewControllers = navigationController.flatMap { Array($0.viewControllers[index..<$0.viewControllers.count]) } ?? []
                
                // dismiss all presented VCs on VCs to be removed
                toRemoveViewControllers.forEach { vc in
                    if vc.presentedViewController != nil {
                        vc.dismiss(animated: animated)
                    }
                }
                
                // VCs to remain in the navigation stack
                let remainingViewControllers = Array(navigationController?.viewControllers[0..<index] ?? [])
                navigationController?.setViewControllers(remainingViewControllers, animated: animated)
            }
            
            // stopping FC doesn't need to be nav delegate anymore -> pass it to parent
            navigationController?.delegate = parentCoordinator
            
            parentCoordinator?.removeChild(self)
        }
        
        // MARK: - Child coordinators
        
        public func addChild(_ flowController: FlowCoordinator) {
            if !childCoordinators.contains(where: { $0 === flowController }) {
                childCoordinators.append(flowController)
                flowController.parentCoordinator = self
            }
        }
        
        public func removeChild(_ flowController: FlowCoordinator) {
            if let index = childCoordinators.firstIndex(where: { $0 === flowController }) {
                childCoordinators.remove(at: index)
            }
        }
        
        // MARK: - UINavigationControllerDelegate
        
        public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
            
            // ensure the view controller is popping
            guard
                let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
                !navigationController.viewControllers.contains(fromViewController)
                else { return }
            
            if let firstViewController = rootViewController, fromViewController == firstViewController {
                navigationController.delegate = parentCoordinator
                stop()
            }
        }
        
        // MARK: - DeepLink
        
        /// Handle deep link with currently active coordinator. If not handled, function returns false
        @discardableResult open func handleDeeplink(_ deeplink: DeepLinkType) -> Bool {
            return activeChild?.handleDeeplink(deeplink) ?? false
        }
        
        // MARK: - Debug
        
        override public init() {
            super.init()
            if QBase.isLoggingEnabled {
                if #available(iOS 10.0, *) {
                    os_log("Initialized %@", log: QBase.Logger.lifecycleLog(), type: .info, "\(self)")
                } else {
                    NSLog("Initialized \(self)")
                }
            }
        }
        
        deinit {
            if QBase.isLoggingEnabled {
                if #available(iOS 10.0, *) {
                    os_log("Deinitialized %@", log: QBase.Logger.lifecycleLog(), type: .info, "\(self)")
                } else {
                    NSLog("Deinitialized \(self)")
                }
            }
        }
    }
}
