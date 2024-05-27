//
//  CVMWETableView.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 24.05.2024.
//

import UIKit

final class CVMWETableView: UITableView {
    var didDelete: ((WorkExperience) -> Void)?
    var didAddMore: (() -> Void)?
    
    lazy var elements = [CVMWETableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CVMWETableView {
    func setup(elements: [CVMWETableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension CVMWETableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .title:
            return dequeueReusableCell(withIdentifier: String(describing: CVMWETitleCell.self), for: indexPath)
        case .workExperience(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: CVMWEEntityCell.self), for: indexPath) as! CVMWEEntityCell
            cell.setup(element: element)
            cell.didDelete = { [weak self] in
                self?.didDelete?(element)
            }
            return cell
        case .addMore:
            let cell = dequeueReusableCell(withIdentifier: String(describing: CVMWEAddCell.self), for: indexPath) as! CVMWEAddCell
            cell.didTap = { [weak self] in
                self?.didAddMore?()
            }
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension CVMWETableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: Private
private extension CVMWETableView {
    func initialize() {
        register(CVMWETitleCell.self, forCellReuseIdentifier: String(describing: CVMWETitleCell.self))
        register(CVMWEEntityCell.self, forCellReuseIdentifier: String(describing: CVMWEEntityCell.self))
        register(CVMWEAddCell.self, forCellReuseIdentifier: String(describing: CVMWEAddCell.self))
        
        dataSource = self
        delegate = self
    }
}
