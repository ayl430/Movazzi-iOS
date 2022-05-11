//
//  MovieCollectionViewCell.swift
//  Movazzi
//
//  Created by yeri on 2022/03/25.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MovieCollectionViewCell"
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        addSubview(imageView)
    }
    
    func setConstraints() {
        imageViewConstraint()
    }
    
    // MARK: - Constraints
    
    private func imageViewConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
