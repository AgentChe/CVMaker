//
//  SelectProfessionalSkillViewModel.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 27.05.2024.
//

import RxSwift
import RxCocoa

final class SelectProfessionalSkillViewModel {
    enum Route {
        case selected(ProfessionalSkill)
    }
    
    private lazy var activity = RxActivityIndicator()
    
    private lazy var contentManager = ContentManager()
}

// MARK: Public
extension SelectProfessionalSkillViewModel {
    struct Input {
        let filter: Signal<String>
        let didSelect: Signal<ProfessionalSkill>
    }
    
    struct Output {
        let activity: Driver<Bool>
        let skills: Driver<[ProfessionalSkill]>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            activity: activity.asDriver(),
            skills: makeSkills(filter: input.filter),
            route: makeRoute(didSelect: input.didSelect)
        )
    }
}

// MARK: Private
private extension SelectProfessionalSkillViewModel {
    func makeSkills(filter: Signal<String>) -> Driver<[ProfessionalSkill]> {
        filter
            .asDriver(onErrorDriveWith: .never())
            .flatMapLatest { [weak self] filter -> Driver<[ProfessionalSkill]> in
                guard let self else { return .never() }
                
                return contentManager
                    .obtainProfessionalSkills(search: filter)
                    .trackActivity(activity)
                    .asDriver(onErrorJustReturn: [])
            }
            .startWith([])
    }
    
    func makeRoute(didSelect: Signal<ProfessionalSkill>) -> Driver<Route> {
        didSelect
            .map { Route.selected($0) }
            .asDriver(onErrorDriveWith: .never())
    }
}
