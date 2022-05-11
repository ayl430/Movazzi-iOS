//
//  DetailDiaryViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/22.
//

import UIKit
import SDWebImage
import RealmSwift

class DetailDiaryViewController: UIViewController {

    // MARK: - Properties

    let realm = try! Realm()
    
    var diaryInfo: Diary?
    
    let posterBaseURL = "https://image.tmdb.org/t/p/w500"

    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let posterImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.font = UIFont(name: "HCR Dotum", size: 16.0)
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제하기", for: .normal)
        button.setTitleColor(UIColor.titleGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "HCR Dotum Bold", size: 16.0)
        button.backgroundColor = .cellGray
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        addViews()
        setConnstraints()
            
        setDiary()

    }
    
    // MARK: - Handlers
    
    private func setUp() {
        deleteButtonConfigure()
    }
    
    func deleteButtonConfigure() {
        deleteButton.addTarget(self, action: #selector(deleteButtonAction(_:)), for: .touchUpInside)
        
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(rateLabel)
        scrollView.addSubview(reviewLabel)
        scrollView.addSubview(deleteButton)
    }
    
    private func setConnstraints() {
        scrollViewConstraint()
        
        imageViewConstraint()
        dateLabelConstraint()
        titleLabelConstraint()
        rateLabelConstraint()
        reviewLabelConstraint()
        deleteButtonConstraint()
    }
    
    func setDiary() {
        
        guard let posterPath = diaryInfo?.posterPath else { return }
        let posterFullPath = "\(posterBaseURL)\(posterPath)"
        posterImageView.sd_setImage(with: URL(string: posterFullPath), completed: nil)
        
        dateLabel.text = diaryInfo?.date
        titleLabel.text = diaryInfo?.title
        
        if let diaryRate = diaryInfo?.rate {
            switch diaryRate {
            case 0:
                rateLabel.text = "☆☆☆☆☆"
            case 1:
                rateLabel.text = "★☆☆☆☆"
            case 2:
                rateLabel.text = "★★☆☆☆"
            case 3:
                rateLabel.text = "★★★☆☆"
            case 4:
                rateLabel.text = "★★★★☆"
            case 5:
                rateLabel.text = "★★★★★"
            default :
                break
                
            }
        }
        
        reviewLabel.text = diaryInfo?.review
    }
    
    @objc func deleteButtonAction(_ sender: UIButton) {
        print("삭제하기")
        
        guard let diaryInfo = diaryInfo else { return }
        let diaryId = diaryInfo._id
        
        guard let diary = realm.object(ofType: Diary.self, forPrimaryKey: diaryId) else { return }
        
        do {
            try realm.write {
                realm.delete(diary)
            }
        } catch {
            print("Error Deleting bookmark: \(error)")
        }
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Constraints
   
    private func scrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func imageViewConstraint() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        posterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5).isActive = true
    }
    
    private func dateLabelConstraint() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 40).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40).isActive = true
        
    }
    
    private func titleLabelConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40).isActive = true
    }
    
    private func rateLabelConstraint() {
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        rateLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        rateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40).isActive = true
    }
    
    private func reviewLabelConstraint() {
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewLabel.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 40).isActive = true
        reviewLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        reviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true

    }
    
    private func deleteButtonConstraint() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 50).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
    }


}
