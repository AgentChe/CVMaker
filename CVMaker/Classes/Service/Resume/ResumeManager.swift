//
//  ResumeManager.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 26.08.2024.
//

import RxSwift
import RxCocoa

protocol ResumeManagerProtocol {
    func obtainCVTemplates() -> Single<[CVTemplate]>
    func obtainCVs() -> Single<[CV]>
    func createCV(template: CVTemplate, profile: Profile) -> Single<CV>
}

final class ResumeManager {
    enum Constants {
        static let cvKey = "resume_manager_cv_key"
    }
}

// MARK: ResumeManagerProtocol
extension ResumeManager: ResumeManagerProtocol {
    func obtainCVTemplates() -> Single<[CVTemplate]> {
        Single<[CVTemplate]>.create { single in
            let templates: [CVTemplate] = [
                CVTemplate(identifier: .template1),
                CVTemplate(identifier: .template2),
                CVTemplate(identifier: .template3),
                CVTemplate(identifier: .template4),
                CVTemplate(identifier: .template5),
                CVTemplate(identifier: .template6),
                CVTemplate(identifier: .template7),
                CVTemplate(identifier: .template8),
                CVTemplate(identifier: .template9),
                CVTemplate(identifier: .template10),
                CVTemplate(identifier: .template11),
                CVTemplate(identifier: .template12),
                CVTemplate(identifier: .template13),
                CVTemplate(identifier: .template14),
                CVTemplate(identifier: .template15),
                CVTemplate(identifier: .template16)
            ]
            single(.success(templates))
            
            return Disposables.create()
        }
    }
    
    func obtainCVs() -> Single<[CV]> {
        Single<[CV]>.create { single in
            let cvs: [CV] = {
                guard let data = UserDefaults.standard.data(forKey: Constants.cvKey) else { return [] }
                let array = try? JSONDecoder().decode([CV].self, from: data)
                return array ?? []
            }()
            
            single(.success(cvs))
            
            return Disposables.create()
        }
    }
    
    func createCV(template: CVTemplate, profile: Profile) -> Single<CV> {
        Single<CV>.create { single in
            var cvs: [CV] = {
                guard let data = UserDefaults.standard.data(forKey: Constants.cvKey) else { return [] }
                let array = try? JSONDecoder().decode([CV].self, from: data)
                return array ?? []
            }()
            
            let cv = CV(
                template: template, 
                profile: profile,
                created: Date()
            )
            cvs.append(cv)
            
            if let data = try? JSONEncoder().encode(cvs) {
                UserDefaults.standard.setValue(data, forKey: Constants.cvKey)
            }
            
            single(.success(cv))
            
            return Disposables.create()
        }
    }
}
