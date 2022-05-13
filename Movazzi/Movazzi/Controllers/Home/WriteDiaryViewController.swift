//
//  WriteDiaryViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/18.
//

import UIKit
import Alamofire
import RealmSwift

class WriteDiaryViewController: UIViewController {
    
    // MARK: - Properties
    
    let writeDiaryView = WriteDiaryUIView()
    
    var movieTitle = ""
    var movieId = 0
    var posterPath = ""
    
    let rateArray = ["0", "1", "2", "3", "4", "5"]
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addViews()
        setConstraints()
        
        createDatePickerView()
        writeDiaryView.movieTitleLabel.text = movieTitle
        createRatePickerView()
        
        writeDiaryView.reviewTextView.delegate = self
        
    }


        // MARK: - Handlers
    
    func setUp() {
        ratePickerViewConfigure()
        saveButtonConfigure()
    }

    func ratePickerViewConfigure() {
        writeDiaryView.ratePicker.delegate = self
        writeDiaryView.ratePicker.dataSource = self
    }
    
    func saveButtonConfigure() {
        writeDiaryView.saveButton.addTarget(self, action: #selector(saveButtonAction(_:)), for: .touchUpInside)
    }
    
   func addViews() {
       view.addSubview(writeDiaryView)
    }
    
    func setConstraints() {
        writeDiaryViewConstraint()
    }

    // 날짜 피커뷰
    func createDatePickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.dateCancelPressed))
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        
        writeDiaryView.datePicker.preferredDatePickerStyle = .wheels
        writeDiaryView.datePicker.datePickerMode = .date
        
        writeDiaryView.dateTextField.inputAccessoryView = toolbar
        writeDiaryView.dateTextField.inputView = writeDiaryView.datePicker
    }
    
    
    @objc func dateDonePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        writeDiaryView.dateTextField.text = formatter.string(from: writeDiaryView.datePicker.date)
        
        self.view.endEditing(true)
    }
    
    @objc func dateCancelPressed() {
        writeDiaryView.dateTextField.text = nil
        
        self.view.endEditing(true)
    }

    // 평가 피커뷰
    func createRatePickerView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.rateDonePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.rateCancelPressed))

        
        toolbar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        writeDiaryView.rateTextField.inputAccessoryView = toolbar
        writeDiaryView.rateTextField.inputView = writeDiaryView.ratePicker
           
    }

    @objc func rateDonePressed() {
        let row = writeDiaryView.ratePicker.selectedRow(inComponent: 0)
        writeDiaryView.ratePicker.selectRow(row, inComponent: 0, animated: true)
        writeDiaryView.rateTextField.text = rateArray[row]
        
        self.view.endEditing(true)
    }
    
    @objc func rateCancelPressed() {
        writeDiaryView.rateTextField.text = nil
        
        self.view.endEditing(true)
    }
    
    // 저장하기 버튼 - 영화 id, 포스터, 작성일, 관람일, 제목, 평가, 리뷰
    @objc func saveButtonAction(_ sender:UIButton!) {
        
        let diaryDate = writeDiaryView.dateTextField.text ?? ""
        let diaryRate = writeDiaryView.rateTextField.text ?? ""
        let diaryReview = writeDiaryView.reviewTextView.text ?? ""
        
        if !diaryDate.isEmpty && !diaryRate.isEmpty && !diaryReview.isEmpty {
            let newDiary = Diary()
            
            newDiary.movieId = movieId
            newDiary.posterPath = posterPath
            newDiary.writeDate = Date()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            let dateString = dateFormatter.string(from: writeDiaryView.datePicker.date)
            newDiary.date = dateString
            
            newDiary.title = writeDiaryView.movieTitleLabel.text ?? "제목 없음"
            
            newDiary.rate = Int(diaryRate) ?? 0

            newDiary.review = diaryReview
            
            save(diary: newDiary)
            
            guard let previousController = self.navigationController?.previousViewController else { return }
            self.navigationController?.popViewControllerWithHandler(animated: true, completion: {
                self.showToast(controller: previousController, message: "저장 완료", font: .systemFont(ofSize: 14.0))
            })
        } else {
            emptyTextFieldAlert()
        }
    }
    
    func emptyTextFieldAlert() {
        let alert = UIAlertController(title: "알림", message: "빈칸을 모두 입력하세요", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        present(alert, animated: true)
    }

    func save(diary: Diary) {
        
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(diary)
            }
        } catch {
            print("Error saving diary: \(error)")
        }
    }

    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - Constraints
    
    private func writeDiaryViewConstraint() {
        writeDiaryView.translatesAutoresizingMaskIntoConstraints = false
        writeDiaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        writeDiaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        writeDiaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        writeDiaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}


// MARK: - PickerViewDelegate, PickerViewDataSource
extension WriteDiaryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rateArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rateArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        writeDiaryView.rateTextField.text = rateArray[row]
    }


}


// MARK: - TextFieldDelegate

extension WriteDiaryViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        guard let text = textView.text,
              let textRange = Range(range, in: text) else { return true }


        let chagedText = text.replacingCharacters(in: textRange, with: text)

        writeDiaryView.textCountLabel.text = "(\(chagedText.count) / 1000)"

        return chagedText.count <= 1000

    }

    
}


