//
//  BoxOfficeCollectionViewCell.swift
//  Movazzi
//
//  Created by yeri on 2022/03/21.
//

import UIKit

class BoxOfficeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "BoxOfficeCollectionViewCell"
    
    let posterView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame:CGRect) {
        super.init(frame: frame)

        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Handlers
    
    private func addViews() {
        addSubview(posterView)
    }
    
    private func setConstraints() {
        posterViewConstraints()
    }

    // MARK: - Constraints

    private func posterViewConstraints() {
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        posterView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -5).isActive = true
        posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        posterView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}
