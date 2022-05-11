//
//  MovieInfoUIView.swift
//  Movazzi
//
//  Created by yeri on 2022/04/24.
//

import Foundation
import UIKit

class MovieInfoUIView: UIView {
    
    // MARK: - Properties
    
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonGray
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    let diaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonGray
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
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
        label.textAlignment = .justified
        label.textColor = .subtitleGray
        label.font = UIFont(name: "NanumGothicCoding", size: 18.0)
        return label
    }()
    
    let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicCoding", size: 18.0)
        return label
    }()
    
    let voteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicCoding", size: 18.0)
        return label
    }()
    
    let overviewHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "줄거리"
        label.textColor = .tintColorYellow
        label.font = UIFont(name: "HCR Dotum", size: 18.0)
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let backdropView: UIImageView = UIImageView()
    
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
        configureBackView()
    }
    
    func configureBackView() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 50
        backView.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    func addViews() {
        addSubview(backView)
        addSubview(posterView)
        addSubview(bookmarkButton)
        addSubview(diaryButton)
        addSubview(titleLabel)
        addSubview(originalTitleLabel)
        addSubview(releaseYearLabel)
        addSubview(voteLabel)
        addSubview(overviewHeaderLabel)
        addSubview(overviewLabel)
        addSubview(backdropView)
    }
    
    func setConstraints() {
        backViewConstraint()
        posterViewConstraint()
        bookmarkButtonConstraint()
        diaryButtonConstraint()
        titleLabelConstraint()
        originalTitleLabelConstraint()
        releaseYearLabelConstraint()
        voteLabelConstraint()
        overviewHeaderLabelConstraint()
        overviewLabelConstraint()
        backdropViewConstraint()
    }
    
    
    // MARK: - Constraints
    
    private func backViewConstraint() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200).isActive = true
        backView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func posterViewConstraint() {
        posterView.translatesAutoresizingMaskIntoConstraints = false
        posterView.topAnchor.constraint(equalTo: backView.topAnchor, constant: -80).isActive = true
        posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        posterView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: -35).isActive = true
        posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.5).isActive = true
    }

    private func bookmarkButtonConstraint() {
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.trailingAnchor.constraint(equalTo: diaryButton.leadingAnchor, constant: -15).isActive = true
        bookmarkButton.bottomAnchor.constraint(equalTo: posterView.bottomAnchor).isActive = true
        bookmarkButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bookmarkButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func diaryButtonConstraint() {
        diaryButton.translatesAutoresizingMaskIntoConstraints = false
        diaryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        diaryButton.bottomAnchor.constraint(equalTo: posterView.bottomAnchor).isActive = true
        diaryButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        diaryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func titleLabelConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35).isActive = true
        
    }
    
    private func originalTitleLabelConstraint() {
        originalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        originalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        originalTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        originalTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func releaseYearLabelConstraint() {
        releaseYearLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseYearLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 20).isActive = true
        releaseYearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        releaseYearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func voteLabelConstraint() {
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.topAnchor.constraint(equalTo: releaseYearLabel.bottomAnchor, constant: 10).isActive = true
        voteLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        voteLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func overviewHeaderLabelConstraint() {
        overviewHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewHeaderLabel.topAnchor.constraint(equalTo: voteLabel.bottomAnchor, constant: 30).isActive = true
        overviewHeaderLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        overviewHeaderLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func overviewLabelConstraint() {
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.topAnchor.constraint(equalTo: overviewHeaderLabel.bottomAnchor, constant: 10).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func backdropViewConstraint() {
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        backdropView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 30).isActive = true
        backdropView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        backdropView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        backdropView.heightAnchor.constraint(equalTo: backdropView.widthAnchor, multiplier: 0.5).isActive = true
        backdropView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
    }
    
    
}
