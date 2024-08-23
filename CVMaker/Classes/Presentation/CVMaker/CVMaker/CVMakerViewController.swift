//
//  CVMakerViewController.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 20.05.2024.
//

import UIKit
import RxSwift

final class CVMakerViewController: UIViewController {
    private lazy var mainView = CVMakerView(vc: self) {
        // TODO
    }
    
    private lazy var viewModel = CVMakerViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: CVMakerViewModel.Input(
            didSaveGeneralInfo: mainView.didCollectedGeneralInfo,
            didSaveWorkExperiences: mainView.didCollectedWorkExperience,
            didSaveEducations: mainView.didCollectedEducations,
            didSaveProfessionalSkills: mainView.didCollectedProfessionalSkills,
            didSaveLanguages: mainView.didCollectedLanguages
        ))
        
        output.profile
            .drive(Binder(mainView) { base, profile in
                base.generalInfoView.setup(generalInfo: profile.generalInfo)
                base.workExperienceView.setup(workExperiences: profile.workExperiences ?? [])
                base.educationsView.setup(educations: profile.educations ?? [])
                base.professionalSkillsView.setup(professionalSkills: profile.professionalSkills ?? [])
                base.languagesView.setup(languages: profile.languages ?? [])
            })
            .disposed(by: disposeBag)
        
        output.disposable
            .disposed(by: disposeBag)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

// MARK: Public
extension CVMakerViewController {
    static func make() -> CVMakerViewController {
        let vc = CVMakerViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
