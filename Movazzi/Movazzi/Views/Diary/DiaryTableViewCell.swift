//
//  DiaryTableViewCell.swift
//  Movazzi
//
//  Created by yeri on 2022/03/21.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "DiaryTableViewCell"
    
    let colorView: UIView = {
       let view = UIView()
        view.backgroundColor = .backgroundApricot
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tintColorBrown
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .titleGray
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
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
        
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 20
        
    }
    
    // MARK: - Handlers
    
    private func setUp() {
        
    }
    
    private func addViews() {
        addSubview(colorView)
        addSubview(rateLabel)
        addSubview(dateLabel)
        addSubview(titleLabel)

    }
    
    private func setConstraints() {
        colorViewConstraint()
        rateLabelConstraint()
        dateLabelConstraint()
        titleLabelConstraint()

    }
    
    // MARK: - Constraints

    private func colorViewConstraint() {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.centerXAnchor.constraint(equalTo: rateLabel.centerXAnchor).isActive = true
        colorView.centerYAnchor.constraint(equalTo: rateLabel.centerYAnchor).isActive = true
        colorView.widthAnchor.constraint(equalTo: rateLabel.widthAnchor, constant: 25).isActive = true
        colorView.heightAnchor.constraint(equalTo: rateLabel.heightAnchor, constant: 4).isActive = true
    }
    
    private func rateLabelConstraint() {
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -5).isActive = true
        rateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
    }
    
    private func dateLabelConstraint() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: rateLabel.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        
    }
    
    private func titleLabelConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: rateLabel.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor).isActive = true
        
    }


}
