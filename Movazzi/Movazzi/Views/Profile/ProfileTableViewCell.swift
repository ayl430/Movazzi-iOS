//
//  ProfileTableViewCell.swift
//  Movazzi
//
//  Created by yeri on 2022/03/24.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier = "ProfileTableViewCell"
    
    let tableViewLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setUp()
        addViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    func setUp() {
        
    }
    
    func addViews() {
        addSubview(tableViewLabel)
    }
    
    func setConstraints() {
        labelConstraints()
    }
    
    // MARK: - Constraints
    
    private func labelConstraints() {
        tableViewLabel.translatesAutoresizingMaskIntoConstraints = false
        tableViewLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tableViewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        tableViewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
    }
}
