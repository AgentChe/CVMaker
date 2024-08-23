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
    func obtainProfessionalSkills(search: String) -> Single<[ProfessionalSkill]>
    func obtainLanguages() -> Single<ISOLanguages>
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
    
    func obtainProfessionalSkills(search: String) -> Single<[ProfessionalSkill]> {
        let request = GetProfessionalSkillsRequest(search: search)
        
        return restApiTransport
            .callServerApi(requestBody: request)
            .map { ProfessionalSkill.map(apilayerResponse: $0) }
    }
    
    func obtainLanguages() -> Single<ISOLanguages> {
        Single<ISOLanguages>.create { single in
            let result: ISOLanguages = {
                guard
                    let url = Bundle.main.url(forResource: "Languages", withExtension: "json"),
                    let data = try? Data(contentsOf: url),
                    let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                else { return [] }
                
                return ISOLanguages.map(resourceJSON: json)
            }()
            single(.success(result))
            
            return Disposables.create()
        }
    }
}
