//
//  ProfileViewController.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 28.08.2024.
//

import UIKit
import RxSwift

final class ProfileViewController: UIViewController {
    private lazy var mainView = ProfileView()
    
    private lazy var viewModel = ProfileViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var settingsButton = TapAreaButton()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationButtons()
        
        let output = viewModel.configure(input: ProfileViewModel.Input(
            didTapSettings: settingsButton.rx.tap.asSignal()
        ))
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension ProfileViewController {
    static func make() -> ProfileViewController {
        let vc = ProfileViewController()
        vc.navigationItem.title = "Profile.Title".localized
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension ProfileViewController {
    func addNavigationButtons() {
        settingsButton.setImage(UIImage(named: "Profile.Settings"), for: .normal)
        
        let item = UIBarButtonItem(customView: settingsButton)
        item.customView?.translatesAutoresizingMaskIntoConstraints = false
        
        item.customView?.widthAnchor.constraint(equalToConstant: 15.scale).isActive = true
        item.customView?.heightAnchor.constraint(equalToConstant: 16.scale).isActive = true
        
        navigationItem.rightBarButtonItem = item
    }
    
    func route(_ route: ProfileViewModel.Route) {
        switch route {
        case .settings:
            let vc = SettingsViewController.make()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
