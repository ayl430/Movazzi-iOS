//
//  ProfileViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var userId: String?
    
    var tableViewArray: [String] = ["닉네임 등록하기","프로필 사진 수정하기"]
    
    let profileView = ProfileUIView()
    
    let picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.modalPresentationStyle = .popover

        return picker
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        setUp()
        addViews()
        setConstraints()

        setUserName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getSavedImage(fileName: "profileImage.png")
    }
    
    // MARK: - Handlers
    
    func setUp() {
        configureImageView()
        configureTableView()
        configurePickerView()
    }
    
    func configureImageView() {
        profileView.profileImageView.layer.cornerRadius = view.frame.width/4
        profileView.profileImageView.clipsToBounds = true
    }
    
    func configureTableView() {
        profileView.profileTableView.delegate = self
        profileView.profileTableView.dataSource = self
    }
    
    func configurePickerView() {
        picker.delegate = self
    }
    
    func addViews() {
        view.addSubview(profileView)
    }
    
    func setConstraints() {
        profileViewConstraint()
    }
    
    private func nickNameAlert() {
        let alert = UIAlertController(title: "닉네임", message: "닉네임을 입력하세요", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "1~10자 사이"
            field.returnKeyType = .continue
            field.delegate = self
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            
            guard let fields = alert.textFields else { return }
            let nickmaneField = fields[0]
            guard let nickname = nickmaneField.text, !nickname.isEmpty else {
                print("Invalid entry")
                return
            }
            print("nickname: \(nickname)")
            UserDefaults.standard.set(nickname, forKey: "nickname")
            
            var userId:String?
            userId = UUID().uuidString
            UserDefaults.standard.setValue(userId, forKey: "user_id")
            
            self.profileView.userNameLabel.text = nickname
            
            DispatchQueue.main.async {
                self.tableViewArray[0] = "닉네임 수정하기"
                self.profileView.profileTableView.reloadData()
            }
            
            
        }))
        
        present(alert, animated: true)
    }
    
    
    func setUserName() {
        
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            profileView.userNameLabel.text = nickname
            tableViewArray[0] = "닉네임 수정하기"
            
        } else {
            profileView.userNameLabel.text = "닉네임을 등록해주세요!"
        }
    }
    
    func imageActionSheet() {

        let alert = UIAlertController(title: "프로필 사진", message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "지금 촬영하기", style: .default) { action in
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        }
        
        let photoLibrary = UIAlertAction(title: "앨범에서 선택하기", style: .default) { action in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        
        let delete = UIAlertAction(title: "현재 사진 지우기", style: .destructive) { action in
            self.profileView.profileImageView.image = UIImage(named: "movazzi-profile")
            self.removeImage()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(camera)
        alert.addAction(photoLibrary)
        alert.addAction(delete)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
    
    func saveImage() {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        if let data = profileView.profileImageView.image?.pngData() {
            let url = documentsDirectory.appendingPathComponent("profileImage.png")
            
            do {
                try data.write(to: url)
                UserDefaults.standard.set(url, forKey: "profileImage")
            } catch {
                print("Unable to Write Data to Disk: (\(error))")
            }
            
        }
        
    }
    
    func getSavedImage(fileName: String) {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = path.appendingPathComponent(fileName)
        
        if let data = try? Data(contentsOf: url) {
            guard let savedImage = UIImage(data: data) else { return }
            let rotatedImage = rotateImage(image: savedImage)
            profileView.profileImageView.image = rotatedImage
        } else {
            profileView.profileImageView.image = UIImage(named: "movazzi-profile")
            print("Unable to load image from Disk: (\(fileName))")
        }
        
    }
    
    func rotateImage(image:UIImage) -> UIImage? {
        
        if (image.imageOrientation == UIImage.Orientation.up) {
            return image
        }
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return copy
    }
    
    func removeImage() {
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent("profileImage.png")
        
        do {
            try fileManager.removeItem(at: url)
        } catch {
            print("Could not clear temp folder: \(error)")
        }
        
    }
    
    // MARK: - Constraints
    
    private func profileViewConstraint() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

    // MARK: - TableViewDelegate, TableViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
       
        let label = cell.tableViewLabel as UILabel
        label.text = tableViewArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("닉네임 등록/수정")
            nickNameAlert()
        case 1:
            print("사진 수정")
            imageActionSheet()
        default:
            print("default")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}


    // MARK: - TextFieldDelegate

extension ProfileViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        
        return newLength <= 10
    }
}


// MARK: - ImagePickerControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[.originalImage] as? UIImage {
            profileView.profileImageView.image = selectedImage
            saveImage()
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
