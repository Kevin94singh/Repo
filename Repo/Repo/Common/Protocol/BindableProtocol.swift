//
//  BindableProtocol.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import RxSwift

/// Bindable protocol
public protocol BindableProtocol: class {
    
    // MARK: - Properties
    
    var disposeBag: DisposeBag { get }
    
    /// Binds actions in view model
    func bind()
    
}
