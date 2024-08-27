//
//  MainViewController.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 27.08.2024.
//

import UIKit
import RxSwift

final class MainViewController: UIViewController {
    private lazy var mainView = MainView()
    
    private lazy var viewModel = MainViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var profileButton = TapAreaButton()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationButtons()
        
        let output = viewModel.configure(input: MainViewModel.Input(
            didTapProfile: profileButton.rx.tap.asSignal()
        ))
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension MainViewController {
    static func make() -> MainViewController {
        let vc = MainViewController()
        vc.navigationItem.title = "Main.Title".localized
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: Private
private extension MainViewController {
    func route(_ route: MainViewModel.Route) {
        switch route {
        case .profile:
            let vc = ProfileViewController.make()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func addNavigationButtons() {
        profileButton.setImage(UIImage(named: "Main.Profile"), for: .normal)
        
        let item = UIBarButtonItem(customView: profileButton)
        item.customView?.translatesAutoresizingMaskIntoConstraints = false
        
        item.customView?.widthAnchor.constraint(equalToConstant: 15.scale).isActive = true
        item.customView?.heightAnchor.constraint(equalToConstant: 16.scale).isActive = true
        
        navigationItem.rightBarButtonItem = item
    }
}
