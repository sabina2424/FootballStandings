//
//  ImageTitleTableViewCell.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import UIKit

class ImageTitleTableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    lazy var logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.numberOfLines = 0
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
    
    func configure(item: Item) {
        for value in item.items ?? [] {
            let label = UILabel()
            label.textAlignment = .center
            label.text = value
            stackView.addArrangedSubview(label)
        }
        configureLayout()
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.text = item.titleLabel
        logoImageView.downloadImage(urlString: item.image ?? "")
    }
    
    private func configureLayout() {
        [logoImageView, titleLabel, stackView].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImageView.widthAnchor.constraint(equalToConstant: 15),
            logoImageView.heightAnchor.constraint(equalToConstant: 15),
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 6),
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

extension ImageTitleTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}


