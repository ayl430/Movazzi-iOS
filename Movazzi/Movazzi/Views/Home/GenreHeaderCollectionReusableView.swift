//
//  GenreHeaderCollectionReusableView.swift
//  Movazzi
//
//  Created by yeri on 2022/03/28.
//

import UIKit

class GenreHeaderCollectionReusableView: UICollectionReusableView {
    // MARK: - Properties
    
    static let identifier = "GenreCollectionViewHeader"
    
    let label:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HCR Dotum Bold", size: 20.0)
        return label
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
        addSubview(label)
    }
    
    func setConstraints() {
        labelConstraint()
    }
    
    // MARK: - Constraints
    
    private func labelConstraint() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
    }
}
