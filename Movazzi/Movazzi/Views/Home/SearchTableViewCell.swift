//
//  SearchTableViewCell.swift
//  Movazzi
//
//  Created by yeri on 2022/03/17.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SearchTableViewCell"
    
    let posterView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "NanumGothicCoding", size: 16.0)
        return label
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.dropShadow()
        
        setUp()
        addViews()
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentView.frame = contentView.frame.inset(by: margins)

        contentView.layer.cornerRadius = 20
        
    }
    

    
    // MARK: - Handlers
    
    private func setUp() {
        
    }
    
    private func addViews() {
        addSubview(posterView)
        addSubview(titleLabel)
        addSubview(originalTitleLabel)
        
    }
    
    private func setConstraints() {
        posterViewConstraint()
        labelConstraint()
        originalTitleLabelConstraint()
        
    }
    
    // MARK: - Constraints

    private func posterViewConstraint() {
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        posterView.widthAnchor.constraint(equalTo: posterView.heightAnchor, multiplier: 2/3).isActive = true
        posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        posterView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func labelConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
    }
    
    private func originalTitleLabelConstraint() {
        originalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        originalTitleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 25).isActive = true
        originalTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
    }
}

