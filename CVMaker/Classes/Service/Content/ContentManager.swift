//
//  ContentManager.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 21.05.2024.
//

import RxSwift

protocol ContentManagerProtocol {
    func obtainCountries() -> Single<[Country]>
    func obtainCities(iso2: String) -> Single<[City]>
}

final class ContentManager {
    private lazy var restApiTransport = RestAPITransport()
}

// MARK: ContentManagerProtocol
extension ContentManager: ContentManagerProtocol {
    func obtainCountries() -> Single<[Country]> {
        restApiTransport
            .callServerApi(requestBody: GetCountriesRequest())
            .map { Country.map(from: $0) }
    }
    
    func obtainCities(iso2: String) -> Single<[City]> {
        let request = GetCitiesRequest(iso2: iso2)
        
        return restApiTransport
            .callServerApi(requestBody: request)
            .map { City.map(from: $0) }
    }
}
