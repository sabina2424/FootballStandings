//
//  LeftImageTitleTableViewCell.swift
//  testApp
//
//  Created by 003995_Mac on 21.06.22.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class LeftImageTitlesTableViewCell: UITableViewCell {
    
    lazy var imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var leftImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return title
    }()
    
    lazy var subtitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return title
    }()
    
    lazy var additionalLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return title
    }()
    
    func configure(item: Item) {
        configureLayout()
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.text = item.titleLabel
        subtitleLabel.text = item.subtitleLabel
        additionalLabel.text = item.additionalLabel
        leftImageView.downloadImage(urlString: item.image)
    }
    
    private func configureLayout() {
        contentView.addSubview(imageContainer)
        contentView.addSubview(stackView)
        imageContainer.addSubview(leftImageView)
        [titleLabel, subtitleLabel, additionalLabel].forEach {
            stackView.addArrangedSubview($0)
        }
      
        NSLayoutConstraint.activate([
            
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageContainer.widthAnchor.constraint(equalToConstant: 60),
            imageContainer.heightAnchor.constraint(equalToConstant: 60),
            imageContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            leftImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            leftImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            leftImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            leftImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ])
    }
}

extension LeftImageTitlesTableViewCell {
    struct Item {
        var image: String
        var titleLabel: String
        var subtitleLabel: String?
        var additionalLabel: String?
        
        init(image: String,
             titleLabel: String,
             subtitleLabel: String? = nil,
             additionalLabel: String? = nil) {
            self.titleLabel = titleLabel
            self.image = image
            self.subtitleLabel = subtitleLabel
            self.additionalLabel = additionalLabel
        }
    }
}

extension LeftImageTitlesTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
