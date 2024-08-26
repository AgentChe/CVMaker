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
            didSaveGeneralInfo: mainView.onboardinView.didCollectedGeneralInfo,
            didSaveWorkExperiences: mainView.onboardinView.didCollectedWorkExperience,
            didSaveEducations: mainView.onboardinView.didCollectedEducations,
            didSaveProfessionalSkills: mainView.onboardinView.didCollectedProfessionalSkills,
            didSaveLanguages: mainView.onboardinView.didCollectedLanguages,
            didSaveInterests: mainView.onboardinView.didCollectedInterests,
            didSaveCertificates: mainView.onboardinView.didCollectedCertificates,
            didSaveSocialMedia: mainView.onboardinView.didCollectedSocialMedia,
            didSaveReferences: mainView.onboardinView.didCollectedReferences
        ))
        
        output.profile
            .drive(Binder(mainView) { base, profile in
                base.onboardinView.generalInfoView.setup(generalInfo: profile.generalInfo)
                base.onboardinView.workExperienceView.setup(workExperiences: profile.workExperiences ?? [])
                base.onboardinView.educationsView.setup(educations: profile.educations ?? [])
                base.onboardinView.professionalSkillsView.setup(professionalSkills: profile.professionalSkills ?? [])
                base.onboardinView.languagesView.setup(languages: profile.languages ?? [])
                base.onboardinView.interestsView.setup(interests: profile.interests ?? [])
                base.onboardinView.certificatesView.setup(certificates: profile.certificates ?? [])
                base.onboardinView.socialMediaView.setup(socialMedia: profile.socialMedia)
                base.onboardinView.referencesView.setup(references: profile.references ?? [])
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
