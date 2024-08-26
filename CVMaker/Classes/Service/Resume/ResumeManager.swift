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
}

final class ResumeManager {
    
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
}
