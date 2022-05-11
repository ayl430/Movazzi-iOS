//
//  ProfileUIView.swift
//  Movazzi
//
//  Created by yeri on 2022/04/29.
//

import Foundation
import UIKit

class ProfileUIView: UIView {
    
    // MARK: - Properties
    
    var tableViewArray: [String] = ["닉네임 등록하기","프로필 이미지 수정하기"]
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()

        return imageView
    }()

    
    var userNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HCR Dotum Bold", size: 25.0)
        label.textAlignment = .center
        return label
    }()
    
    let profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)

        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    func addViews() {
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(profileTableView)
    }
    
    func setConstraints() {
        imageViewConstraint()
        userNameLabelConstraint()
        tableViewConstraint()
    }
    
    // MARK: - Constraints
    
    private func imageViewConstraint() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
    }
    
    private func userNameLabelConstraint() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
    }
    
    private func tableViewConstraint() {
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        profileTableView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 30).isActive = true
        profileTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        profileTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
