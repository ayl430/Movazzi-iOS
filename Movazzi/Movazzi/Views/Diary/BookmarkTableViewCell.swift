//
//  BookmarkTableViewCell.swift
//  Movazzi
//
//  Created by yeri on 2022/03/21.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "BookmarkTableViewCell"
    
    
    let posterView:UIImageView = {
       let imageView  = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HCR Dotum", size: 18.0)
        return label
    }()
    
    let originalTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .subtitleGray
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
        
        let margins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 10
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
        posterViewConstraints()
        labelConstraints()
        originalTitleLabelConstraints()
    }
    
    // MARK: - Constraints
    
    private func posterViewConstraints() {
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        posterView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        posterView.widthAnchor.constraint(equalTo: posterView.heightAnchor, multiplier: 2/3).isActive = true
        posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true

    }

    private func labelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
    }
    
    private func originalTitleLabelConstraints() {
        originalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        originalTitleLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: 25).isActive = true
        originalTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
    }


}
