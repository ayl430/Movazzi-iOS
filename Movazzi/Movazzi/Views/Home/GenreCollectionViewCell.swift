//
//  GenreCollectionViewCell.swift
//  Movazzi
//
//  Created by yeri on 2022/03/21.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "GenreCollectionViewCell"
    
    let genreImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.borderGray.cgColor

        imageView.layer.borderWidth = 1
        imageView.backgroundColor = .cellGray
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HCR Dotum", size: 15.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Init
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setUp()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    
    private func setUp() {
        titleLabel.textAlignment = .center
    }
    
    private func addViews() {
        addSubview(genreImageView)
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        genreImageViewConstraints()
        titleLabelConstraints()
    }

    // MARK: - Constraints

    private func genreImageViewConstraints() {
        genreImageView.translatesAutoresizingMaskIntoConstraints = false
        genreImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        genreImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        genreImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        genreImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
    }
    
    private func titleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: genreImageView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
