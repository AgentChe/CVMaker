//
//  CVMakerViewModel.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 20.05.2024.
//

import RxSwift
import RxCocoa

final class CVMakerViewModel {
    private lazy var profileManager = ProfileManager()
}

// MARK: Public
extension CVMakerViewModel {
    struct Input {
        let didSaveGeneralInfo: Signal<GeneralInfo>
    }
    
    struct Output {
        let profile: Driver<Profile>
        let disposable: Disposable
    }
    
    func configure(input: Input) -> Output {
        Output(
            profile: makeProfile(),
            disposable: makeDisposable(
                didSaveGeneralInfo: input.didSaveGeneralInfo
            )
        )
    }
}

// MARK: Private
private extension CVMakerViewModel {
    func makeProfile() -> Driver<Profile> {
        profileManager
            .obtainProfile()
            .asDriver(onErrorDriveWith: .never())
    }
    
    func makeDisposable(
        didSaveGeneralInfo: Signal<GeneralInfo>
    ) -> Disposable {
        let generalInfo = didSaveGeneralInfo
            .flatMapLatest { [weak self] generalInfo -> Signal<Void> in
                guard let self else { return .never() }
                
                return self.profileManager
                    .set(generalInfo: generalInfo)
                    .asSignal(onErrorSignalWith: .never())
            }
            .emit()
        
        return Disposables.create([
            generalInfo
        ])
    }
}
