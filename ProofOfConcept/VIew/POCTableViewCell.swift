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
    static let HORIZONTAL_SPACING: CGFloat = 5.0
    static let NUMBER_OF_LINES: Int = 0

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subStackView.addArrangedSubview(rowTitleLabel)
        subStackView.addArrangedSubview(rowDescriptionLabel)
        subStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(rowImageView)
        mainStackView.addArrangedSubview(subStackView)
        contentView.addSubview(mainStackView)
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
        label.numberOfLines = NUMBER_OF_LINES
        label.font = UIFont.boldSystemFont(ofSize: TITLE_LABEL_FONT)
        label.textAlignment = NSTextAlignment.center
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let rowDescriptionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = NUMBER_OF_LINES
        label.font = UIFont.systemFont(ofSize: DESCRIPTION_LABEL_FONT, weight: .medium)
        label.textAlignment = NSTextAlignment.left
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let mainStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.top
        stackView.spacing   = HORIZONTAL_SPACING
        stackView.contentMode = .topLeft
        return stackView
    }()
    
    let subStackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = SPACING
        return stackView
      }()
    
    func setStackViewConstraints() {
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: POCTableViewCell.SPACING).isActive = true
        self.mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -POCTableViewCell.SPACING).isActive = true
        self.mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: POCTableViewCell.SPACING).isActive = true
        self.mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -POCTableViewCell.SPACING).isActive = true
        
    }
}
