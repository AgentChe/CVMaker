//
//  CVMakerChapterView.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 21.05.2024.
//

import UIKit

protocol CVMakerChapterViewDelegate: AnyObject {
    func slideViewDidNext(from chapter: CVMakerView.Chapter)
    func slideViewDidBack(from chapter: CVMakerView.Chapter)
}

class CVMakerChapterView: UIView {
    let chapter: CVMakerView.Chapter
    
    weak var delegate: CVMakerChapterViewDelegate?
    
    init(chapter: CVMakerView.Chapter) {
        self.chapter = chapter
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveToThis() {}
    
    @objc
    func onNext() {
        delegate?.slideViewDidNext(from: chapter)
    }
    
    @objc
    func onBack() {
        delegate?.slideViewDidBack(from: chapter)
    }
}
