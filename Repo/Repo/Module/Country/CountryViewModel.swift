//
//  HomeViewModel.swift
//  Repo
//
//  Created by Kevin Singh on 15/11/2020.
//

import Foundation
import RxCocoa
import RxSwift
import Action

protocol CountryViewModelInputs {
    var countryAction: Action<String, CountryItem> { get set }
}

protocol CountryViewModelOutputs {
    var country: BehaviorRelay<CountryItem?> { get }
    var error: BehaviorRelay<Error?> { get }
    var isExecuting: BehaviorRelay<Bool> { get }
}

final class CountryViewModel: BaseViewModel, CountryViewModelInputs, CountryViewModelOutputs {
    typealias Dependencies = HasNetworkManagerDependencies & HasCountryApi
    
    // MARK: - Dependencies
    
    private let dependencies: Dependencies
    
    // MARK: - Initialization
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        bindAction()
    }
    
    // MARK: - Inputs
    
    lazy var countryAction: Action<String, CountryItem> = {
        return Action(workFactory: { [unowned self] (code) -> Single<CountryItem> in
            return self.dependencies.countryApi.getCountry(code: code)
        })
    }()
    
    // MARK: - Inputs
    
    internal let country = BehaviorRelay<CountryItem?>(value: nil)
    internal let error = BehaviorRelay<Error?>(value: nil)
    internal let isExecuting = BehaviorRelay<Bool>(value: false)
}

extension CountryViewModel {
    
    func bindAction() {
        
        countryAction
            .elements
            .bind(to: country)
            .disposed(by: disposeBag)
        
        countryAction
            .underlyingError
            .bind(to: error)
            .disposed(by: disposeBag)
        
        countryAction
            .executing
            .bind(to: isExecuting)
            .disposed(by: disposeBag)
    }
}
