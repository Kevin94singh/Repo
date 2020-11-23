//
//  BaseViewController.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import UIKit
import RxSwift
import QExtensions

class BaseViewController<ViewModelType>: Q.ViewController<ViewModelType>, BindableProtocol {
    
    // MARK: - Properties
        
    private(set) var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Bind
    
    func bind() {
        disposeBag = DisposeBag()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    // MARK: - Navigation methods
    
    func setShadowToNavigationBar() {
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.12
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        navigationController?.navigationBar.layer.shadowRadius = 15
    }
    
    func clearShadowToNavigationBar() {
        navigationController?.navigationBar.layer.shadowOpacity = 0
    }
}
