//
//  POCTableViewCell.swift
//  TelstraAssingment
//
//  Created by Pradeep Kumar Vadde (Digital) on 13/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import UIKit

class POCTableViewCell: UITableViewCell {
    
    static let TITLE_LABEL_FONT: CGFloat = 25.0
    static let DESCRIPTION_LABEL_FONT: CGFloat = 20.0
    static let SPACING: CGFloat = 10.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.addArrangedSubview(rowImageView)
        stackView.addArrangedSubview(rowTitleLabel)
        stackView.addArrangedSubview(rowDescriptionLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        setStackViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let rowImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rowTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: TITLE_LABEL_FONT)
        label.textAlignment = NSTextAlignment.center
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let rowDescriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: DESCRIPTION_LABEL_FONT, weight: .medium)
        label.textAlignment = NSTextAlignment.left
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = SPACING
        return stackView
    }()
    
    func setStackViewConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0).isActive = true
        self.stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
    }
}
