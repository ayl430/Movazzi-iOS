//
//  MovieInfoViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/17.
//

import UIKit
import Alamofire
import SDWebImage
import RealmSwift


class MovieInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    let realm = try! Realm()
    
    var bookmark: Bookmark?
    
    var movie:Movie?
    var movies:[Movie]?
    
    let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    
    let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundYellow
        return view
    }()
    
    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    let whiteView = MovieInfoUIView()
   
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addViews()
        setConstraints()
        
        movieInfo()
        setBookmarkButton()
        setDiaryButton()
    }

    // MARK: - Handlers
    
    private func setUp() {
        
    }
    
    private func addViews() {
        
        view.addSubview(colorView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(whiteView)
    }
    
    private func setConstraints() {
        
        colorViewConstraint()
        scrollViewConstraint()
        
        whiteViewConstraint()
    }
    
    func movieInfo() {
        guard let movie = self.movie else {
            return
        }
        
        let posterPath = movie.posterPath
        let posterFullPath = "\(posterBaseURL)\(posterPath)"
        whiteView.posterView.sd_setImage(with: URL(string: posterFullPath), completed: nil)
        
        whiteView.titleLabel.text = movie.title
        whiteView.originalTitleLabel.text = movie.originalTitle
        whiteView.releaseYearLabel.text = "\(movie.releaseDate.prefix(4))"
        whiteView.voteLabel.text = "★\(movie.voteAverage)"
        
        whiteView.overviewLabel.text = movie.overview
        
        guard let backdropPath = movie.backdropPath else { return }
        let backdropFullPath = "\(posterBaseURL)\(backdropPath)"
        whiteView.backdropView.sd_setImage(with: URL(string: backdropFullPath), completed: nil)
        
    }
    
    func setBookmarkButton() {
        
        guard let movie = self.movie else {
            return
        }

        let movieId = movie.id
        
        whiteView.bookmarkButton.addTarget(self, action: #selector(bookmarkpressed(_:)), for: .touchUpInside)
        
        if realm.object(ofType: Bookmark.self, forPrimaryKey: movieId) != nil {
            whiteView.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            whiteView.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }

    @objc func bookmarkpressed(_ sender: UIButton) {
        
        guard let movie = self.movie else {
            return
        }
        
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            let newBookmark = Bookmark()
            let movieId = movie.id

            newBookmark.movieId = movieId
            newBookmark.originalTitle = movie.originalTitle
            newBookmark.date = Date()
            
            checkBookmark(bookmark: newBookmark, id: movieId)
        } else {
            setNickNameAlert()
        }

        
    }
    
    func checkBookmark(bookmark: Bookmark, id: Int) {
        
        if realm.object(ofType: Bookmark.self, forPrimaryKey: id) != nil {
            delete()
            whiteView.bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            self.showToast(controller: self, message: "즐겨찾기 삭제", font: .systemFont(ofSize: 14.0))
        } else {
            save(bookmark: bookmark)
            whiteView.bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)

            print("북마크 저장")
            self.showToast(controller: self, message: "즐겨찾기 추가", font: .systemFont(ofSize: 14.0))
        }

    }
    
    func save(bookmark: Bookmark) {
        do {
            try realm.write {
                realm.add(bookmark)
            }
        } catch {
            print("Error saving bookmark: \(error)")
        }
    }
    
    func delete() {
        guard let movie = self.movie else {
            return
        }

        let movieId = movie.id
        
        guard let bookmark = realm.object(ofType: Bookmark.self, forPrimaryKey: movieId) else {
            return
        }
        
        do {
            try realm.write {
                realm.delete(bookmark)
            }
        } catch {
            print("Error Deleting bookmark: \(error)")
        }
    }
    
    
    func setDiaryButton() {
        whiteView.diaryButton.addTarget(self, action: #selector(addButtonAction(_:)), for: .touchUpInside)
    }
    
    @objc func addButtonAction(_ sender:UIButton!) {
        
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            
            let storyboard =  UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WriteDiaryView") as! WriteDiaryViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            if let movie = movie {
                vc.movieTitle = movie.title
                vc.movieId = movie.id
                vc.posterPath = movie.posterPath
            }
            
        } else {
            setNickNameAlert()
        }
        
    }
    
    
    func setNickNameAlert() {
        let alert = UIAlertController(title: "닉네임 등록", message: "닉네임 등록 후 이용 가능합니다", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    
    // MARK: - Constraints
    
    private func colorViewConstraint() {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
    }
    
    private func scrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
      
    }

    private func whiteViewConstraint() {
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        whiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

    }
    

    
}

 
    

