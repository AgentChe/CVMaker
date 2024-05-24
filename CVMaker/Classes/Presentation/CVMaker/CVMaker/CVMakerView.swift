//
//  CVMakerView.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 20.05.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class CVMakerView: UIView {
    enum Chapter: Int {
        case generalInfo
        case workExperience
        case education
        case professionalSkills
        case languages
        case interests
        case certificates
        case socialMedia
        case references
    }
    
    var finished: (() -> Void)?
    
    lazy var chaptersView = makeChaptersView()
    lazy var container = makeContainer()
    lazy var chaptersViews: [CVMakerChapterView] = [
        generalInfoView
    ]
    lazy var generalInfoView = CVMakerGeneralInfoView(vc: vc) { [weak self] generalInfo in
        self?.didCollectedGeneralInfoTrigger.accept(generalInfo)
    }
    
    private lazy var didCollectedGeneralInfoTrigger = PublishRelay<GeneralInfo>()
    
    private var chapter = Chapter.generalInfo
    
    private weak var vc: UIViewController?
    
    init(vc: UIViewController) {
        self.vc = vc
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: CVMakerChapterViewDelegate
extension CVMakerView: CVMakerChapterViewDelegate {
    func slideViewDidNext(from chapter: Chapter) {
        let nextRawValue = chapter.rawValue + 1
        
        guard let nextChapter = Chapter(rawValue: nextRawValue) else {
            finished?()
            
            return
        }
        
        scroll(to: nextChapter)
    }
    
    func slideViewDidBack(from chapter: Chapter) {
        let previousRawValue = chapter.rawValue - 1
        
        guard let previousChapter = Chapter(rawValue: previousRawValue) else {
            return
        }
        
        scroll(to: previousChapter)
    }
}

// MARK: Public
extension CVMakerView {
    var didCollectedGeneralInfo: Signal<GeneralInfo> {
        didCollectedGeneralInfoTrigger.asSignal()
    }
}

// MARK: Private
private extension CVMakerView {
    func initialize() {
        backgroundColor = Appearance.main100
        
        chaptersViews
            .forEach { [weak self] view in
                guard let self else { return }
                
                view.clipsToBounds = true
                view.delegate = self
                
                if view.chapter == self.chapter {
                    view.translatesAutoresizingMaskIntoConstraints = false
                    container.addSubview(view)
                    
                    NSLayoutConstraint.activate([
                        view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                        view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                        view.topAnchor.constraint(equalTo: container.topAnchor),
                        view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
                    ])
                    
                    view.layoutIfNeeded()
                    
                    view.moveToThis()
                }
            }
        
        chaptersView.setup(chapter: chapter)
    }
    
    func scroll(to newChapter: Chapter) {
        let currentIndex = chapter.rawValue
        let scrollToIndex = newChapter.rawValue
        
        let direction = scrollToIndex > currentIndex ? 1 : -1
        
        let indices = chaptersViews.indices
        
        guard indices.contains(currentIndex), indices.contains(scrollToIndex) else {
            return
        }

        let currentView = chaptersViews[currentIndex]
        let scrollToView = chaptersViews[scrollToIndex]
        
        scrollToView.frame.size = container.bounds.size
        scrollToView.frame.origin = CGPoint(x: 393.scale * CGFloat(direction), y: 0)
        
        addSubview(scrollToView)
        
        UIView.animate(withDuration: 0.3, animations: {
            currentView.frame.origin = CGPoint(x: 393.scale * CGFloat(-direction), y: 0)
            scrollToView.frame.origin = CGPoint(x: 0, y: 0)
        }, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            
            currentView.removeFromSuperview()
            
            scrollToView.moveToThis()
            
            self.chapter = newChapter
        })
    }
}

// MARK: Make constraints
private extension CVMakerView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            chaptersView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chaptersView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chaptersView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.scale),
            chaptersView.heightAnchor.constraint(equalToConstant: 28.scale)
        ])
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: chaptersView.bottomAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension CVMakerView {
    func makeChaptersView() -> CVMakerChaptersView {
        let view = CVMakerChaptersView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
