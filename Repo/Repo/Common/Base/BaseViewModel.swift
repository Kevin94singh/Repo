//
//  BaseViewModel.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import RxSwift

/// View model base class
class BaseViewModel: BindableProtocol {
    
    // MARK: - Properties
    
    private(set) var disposeBag: DisposeBag = DisposeBag()
    
    /// Initializes view model with bind call
    init() {
        bind()
    }
    
    /// Binds actions in view model
    func bind() {
        disposeBag = DisposeBag()
    }
}
