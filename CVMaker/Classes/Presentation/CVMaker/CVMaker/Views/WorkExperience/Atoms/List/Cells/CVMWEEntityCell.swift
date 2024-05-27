//
//  CVMWEEntityCell.swift
//  CVMaker
//
//  Created by Андрей Чернышев on 24.05.2024.
//

import UIKit

final class CVMWEEntityCell: UITableViewCell {
    var didDelete: (() -> Void)?
    
    lazy var container = makeContainer()
    lazy var stackView = makeStackView()
    lazy var deleteButton = makeDeleteButton()
    
    private lazy var jobTitleAttrs = TextAttributes()
        .textColor(Appearance.main200)
        .font(Fonts.Nunito.extraBold(size: 17.scale))
        .lineHeight(23.19.scale)
        .textAlignment(.left)
    private lazy var companyNameAttrs = TextAttributes()
        .textColor(Appearance.main200)
        .font(Fonts.Nunito.semiBold(size: 17.scale))
        .lineHeight(23.19.scale)
        .textAlignment(.left)
    private lazy var dateAttrs = TextAttributes()
        .textColor(Appearance.main200.withAlphaComponent(0.3))
        .font(Fonts.Nunito.semiBold(size: 15.scale))
        .lineHeight(20.46.scale)
        .textAlignment(.left)
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.yyyy"
        return formatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CVMWEEntityCell {
    func setup(element: WorkExperience) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if let jobTitle = element.jobTitle {
            add(text: jobTitle, attrs: jobTitleAttrs)
        }
        
        if let companyName = element.companyName {
            add(text: companyName, attrs: companyNameAttrs)
        }
        
        if let startDate = element.startDate {
            var result = dateFormatter.string(from: startDate)
            if let endDate = element.endDate {
                result += "- \(dateFormatter.string(from: endDate))"
            }
            
            add(text: result, attrs: dateAttrs)
        }
        
        layoutIfNeeded()
    }
}

// MARK: Private
private extension CVMWEEntityCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func add(text: String, attrs: TextAttributes) {
        let view = UILabel()
        view.attributedText = text.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
    }
    
    @objc
    func deleteTapped() {
        didDelete?()
    }
}

// MARK: Make constraints
private extension CVMWEEntityCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.scale),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32.scale),
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 18.scale),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -18.scale)
        ])
        
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 20.scale),
            deleteButton.heightAnchor.constraint(equalToConstant: 20.scale),
            deleteButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            deleteButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CVMWEEntityCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.mono100
        view.layer.cornerRadius = 12.scale
        view.layer.shadowColor = Appearance.mono200.withAlphaComponent(0.4).cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeStackView() -> UIStackView {
        let view = UIStackView()
        view.backgroundColor = UIColor.clear
        view.axis = .vertical
        view.spacing = 4.scale
        view.distribution = .fill
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeDeleteButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "CVMaker.DeleteWorkExperience"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        container.addSubview(view)
        return view
    }
}
