//
//  AppDependency.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import QExtensions

typealias HasNetworkManagerDependencies = HasNetworkManager
typealias HasCountryApiDependencies = HasCountryApi

// MARK: - Dependencies

final class AppDependency: HasNetworkManagerDependencies, HasCountryApiDependencies {
    lazy var networkManager: NetworkableManager = NetworkManager(dependencies: self)
    lazy var countryApi: CountryApiServicing = CountryApiService(dependencies: self)
}

protocol HasNoDependency {}

extension AppDependency: HasNoDependency {}

let dependencies = AppDependency()

// MARK: - Aliases

typealias Q = QBase
typealias Localizable = R.string.localizable
typealias Images = R.image
