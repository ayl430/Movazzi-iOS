//
//  WriteDiaryUIView.swift
//  Movazzi
//
//  Created by yeri on 2022/04/26.
//

import Foundation
import UIKit
import SwiftUI

class WriteDiaryUIView: UIView {
    
    // MARK: - Properties
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "평가"
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0000년 0월 00일"
        textField.font = UIFont(name: "NanumGothicCoding", size: 16.0)
        textField.tintColor = .clear
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()
    
    let movieTitleLabel = UILabel()
    
    let rateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.font = UIFont(name: "NanumGothicCoding", size: 16.0)
        textField.textAlignment = .center
        textField.tintColor = .clear
        return textField
    }()
    
    let ratePicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    let totalRateLabel: UILabel = {
        let label = UILabel()
        label.text = "점 / 5점"
        label.font = UIFont(name: "NanumGothicCoding", size: 16.0)
        return label
    }()
    
    lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 0.2
        textView.layer.cornerRadius = 10
        textView.layer.backgroundColor = UIColor.backgroundApricot.cgColor
        textView.font = UIFont(name: "HCR Dotum", size: 16.0)
        return textView
    }()
    
    lazy var textCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicCoding", size: 16.0)
        label.text = "(0 / 1000)"
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HCR Dotum", size: 16.0)
        button.backgroundColor = .buttonGray
        button.layer.cornerRadius = 8
        return button
    }()
    
    let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let rateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let rateSubStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.modalPresentationStyle = .popover

        return picker
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
    
    override func layoutSubviews() {
        dateTextField.setUnderLine()
        rateTextField.setUnderLine()
    }

    // MARK: - Handlers
    
    func setUp() {
        
    }
    
    func addViews() {
        
        addSubview(dateStackView)
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateTextField)
        
        addSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(movieTitleLabel)
        
        addSubview(rateStackView)
        rateStackView.addArrangedSubview(rateLabel)
        rateStackView.addArrangedSubview(rateSubStackView)
        rateSubStackView.addArrangedSubview(rateTextField)
        rateSubStackView.addArrangedSubview(totalRateLabel)
        
        addSubview(reviewTextView)
        addSubview(textCountLabel)
        
        addSubview(saveButton)
    }
    
    func setConstraints() {
        
        dateStackViewConstraint()
        dateLabelConstraint()
        dateTextFieldConstraint()
        
        titleStackViewConstraint()
        titleLabelConstraint()
        movieTitleLabelConstraint()
        
        rateStackViewConstraint()
        rateLabelConstraint()
        rateSubStackViewConstraint()
        rateTextFieldConstraint()
        totalRateLabelConstraint()
        
        reviewTextViewConstraint()
        textCountLabelConstraint()
        
        saveButtonwConstraint()
    }
    
    // MARK: - Constraints
    
    // dateConstraints
    private func dateStackViewConstraint() {
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        dateStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -30).isActive = true
    }
    
    private func dateLabelConstraint() {
        dateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func dateTextFieldConstraint() {
        dateTextField.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    // titleConstraints
    private func titleStackViewConstraint() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 20).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
    }
    
    private func titleLabelConstraint() {
        titleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func  movieTitleLabelConstraint() {
        movieTitleLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // rateConstraints
    private func rateStackViewConstraint() {
        rateStackView.translatesAutoresizingMaskIntoConstraints = false
        rateStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20).isActive = true
        rateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        rateStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
    }
    
    private func rateLabelConstraint() {
        rateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func rateSubStackViewConstraint() {
        rateSubStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func rateTextFieldConstraint() {
        rateTextField.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func totalRateLabelConstraint() {
        totalRateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // reviewConstraints
    private func reviewTextViewConstraint() {
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        reviewTextView.topAnchor.constraint(equalTo: rateStackView.bottomAnchor, constant: 20).isActive = true
        reviewTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        reviewTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive  = true
        reviewTextView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -80).isActive = true
    }
    
    
    private func textCountLabelConstraint() {
        textCountLabel.translatesAutoresizingMaskIntoConstraints = false
        textCountLabel.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 10).isActive = true
        textCountLabel.trailingAnchor.constraint(equalTo: reviewTextView.trailingAnchor, constant: -15).isActive = true
    }
 
    private func saveButtonwConstraint() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
