//
//  StatsSectionHeaderView.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import Foundation
import UIKit

class StatsSectionHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.textAlignment = .center
        title.text = "Team"
        title.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return title
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: Item) {
        for value in item.items ?? [] {
            let label = UILabel()
            label.textAlignment = .center
            label.text = value
            stackView.addArrangedSubview(label)
        }
        configureLayout()
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func configureLayout() {
        [titleLabel, stackView].forEach {
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)

        ])
    }
}
