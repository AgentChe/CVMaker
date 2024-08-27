//
//  ProfileViewModel.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 28.08.2024.
//

import RxSwift
import RxCocoa

final class ProfileViewModel {
    enum Route {
        case settings
    }
}

// MARK: Public
extension ProfileViewModel {
    struct Input {
        let didTapSettings: Signal<Void>
    }
    
    struct Output {
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            route: makeRoute(didTapSettings: input.didTapSettings)
        )
    }
}

// MARK: Private
private extension ProfileViewModel {
    func makeRoute(didTapSettings: Signal<Void>) -> Driver<Route> {
        let settings = didTapSettings
            .map { Route.settings }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver.merge(settings)
    }
}
