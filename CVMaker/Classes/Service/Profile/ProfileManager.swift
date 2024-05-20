//
//  ProfileManager.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 20.05.2024.
//

import RxSwift

protocol ProfileManagerProtocol {
    func obtainProfile() -> Single<Profile>
    func set(generalInfo: GeneralInfo) -> Single<Void>
    func set(workExperience: WorkExperience) -> Single<Void>
    func set(education: Education) -> Single<Void>
    func set(professionalSkills: [String]) -> Single<Void>
    func set(languages: [Language]) -> Single<Void>
    func set(interests: [String]) -> Single<Void>
    func set(certificates: [Certificate]) -> Single<Void>
    func set(socialMedia: SocialMedia) -> Single<Void>
    func set(references: [Reference]) -> Single<Void>
    func delete(entity: ProfileManager.Entity) -> Single<Void>
}

final class ProfileManager {
    enum Entity: String {
        case generalInfo = "generalInfo"
        case workExperience = "workExperience"
        case education = "education"
        case professionalSkills = "professionalSkills"
        case languages = "languages"
        case interests = "interests"
        case certificates = "certificates"
        case socialMedia = "socialMedia"
        case references = "references"
    }
}

// MARK: ProfileManagerProtocol
extension ProfileManager: ProfileManagerProtocol {
    func obtainProfile() -> Single<Profile> {
        Single<Profile>.create { [weak self] single in
            guard let self else {
                return Disposables.create()
            }
            
            let profile = Profile(
                generalInfo: cached(entity: .generalInfo),
                workExperience: cached(entity: .workExperience),
                education: cached(entity: .education),
                professionalSkills: cached(entity: .professionalSkills),
                languages: cached(entity: .languages),
                interests: cached(entity: .interests),
                certificates: cached(entity: .certificates),
                socialMedia: cached(entity: .socialMedia),
                references: cached(entity: .references)
            )
            
            single(.success(profile))
            
            return Disposables.create()
        }
    }
    
    func set(generalInfo: GeneralInfo) -> Single<Void> {
        store(object: generalInfo, entity: .generalInfo)
    }
    
    func set(workExperience: WorkExperience) -> Single<Void> {
        store(object: workExperience, entity: .workExperience)
    }
    
    func set(education: Education) -> Single<Void> {
        store(object: education, entity: .education)
    }
    
    func set(professionalSkills: [String]) -> Single<Void> {
        store(object: professionalSkills, entity: .professionalSkills)
    }
    
    func set(languages: [Language]) -> Single<Void> {
        store(object: languages, entity: .languages)
    }
    
    func set(interests: [String]) -> Single<Void> {
        store(object: interests, entity: .interests)
    }
    
    func set(certificates: [Certificate]) -> Single<Void> {
        store(object: certificates, entity: .certificates)
    }
    
    func set(socialMedia: SocialMedia) -> Single<Void> {
        store(object: socialMedia, entity: .socialMedia)
    }
    
    func set(references: [Reference]) -> Single<Void> {
        store(object: references, entity: .references)
    }
    
    func delete(entity: ProfileManager.Entity) -> Single<Void> {
        Single<Void>.create { single in
            UserDefaults.standard.removeObject(forKey: entity.rawValue)
            
            single(.success(Void()))
            
            return Disposables.create()
        }
    }
}

// MARK: Private
private extension ProfileManager {
    func store<T: Codable>(object: T, entity: Entity) -> Single<Void> {
        Single<Void>.create { single in
            if let data = try? JSONEncoder().encode(object) {
                UserDefaults.standard.set(data, forKey: entity.rawValue)
            }
            
            single(.success(Void()))
            
            return Disposables.create()
        }
    }
    
    func cached<T: Decodable>(entity: Entity) -> T? {
        guard let data = UserDefaults.standard.data(forKey: entity.rawValue) else {
            return nil
        }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
