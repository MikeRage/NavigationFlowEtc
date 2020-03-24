//
//  menuTableViewCell.swift
//  NavigationFlowEtc
//
//  Created by Разработчик Foodle on 06/03/2020.
//  Copyright © 2020 Разработчик Foodle. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    private let background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBackground()
        setupTitleLabel()
    }
    
    private func setupBackground() {
        contentView.addSubview(background)
        background.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        background.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        background.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        background.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -5).isActive = true
    }
}
