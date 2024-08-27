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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: MainViewModel.Input())
    }
}

// MARK: Public
extension MainViewController {
    static func make() -> MainViewController {
        MainViewController()
    }
}

// MARK: Private
private extension MainViewController {
    
}
