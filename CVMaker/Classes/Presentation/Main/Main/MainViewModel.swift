//
//  MainViewModel.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 27.08.2024.
//

import RxSwift
import RxCocoa

final class MainViewModel {
    enum Route {
        case profile
    }
}

// MARK: Public
extension MainViewModel {
    struct Input {
        let didTapProfile: Signal<Void>
    }
    
    struct Output {
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        Output(
            route: makeRoute(didTapProfile: input.didTapProfile)
        )
    }
}

// MARK: Private
private extension MainViewModel {
    func makeRoute(didTapProfile: Signal<Void>) -> Driver<Route> {
        let profile = didTapProfile
            .map { Route.profile }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver.merge(profile)
    }
}
