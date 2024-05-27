//
//  CVMWEAddCell.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 24.05.2024.
//

import UIKit

final class CVMWEAddCell: UITableViewCell {
    var didTap: (() -> Void)?
    
    lazy var button = makeButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension CVMWEAddCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    @objc
    func tapped() {
        didTap?()
    }
}

// MARK: Make constraints
private extension CVMWEAddCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32.scale),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 59.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CVMWEAddCell {
    func makeButton() -> DottedButton {
        let view = DottedButton()
        view.backgroundColor = UIColor.clear
        view.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
