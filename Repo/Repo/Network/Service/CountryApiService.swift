//
//  CountryApiService.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

import RxSwift

protocol HasCountryApi {
    var countryApi: CountryApiServicing { get }
}

protocol CountryApiServicing {
    func getCountry(code: String) -> Single<[CountryItem]>
}

final class CountryApiService {
    typealias Dependencies = HasNetworkManagerDependencies
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension CountryApiService: CountryApiServicing {
    func getCountry(code: String) -> Single<[CountryItem]> {
        return dependencies.networkManager.makeRequest(router: CountryApiRouter.getCountry(code: code))
    }
}
