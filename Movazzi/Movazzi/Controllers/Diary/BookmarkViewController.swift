//
//  BookmarkViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/15.
//

import UIKit
import Alamofire
import SDWebImage
import RealmSwift

class BookmarkViewController: UIViewController {
    // MARK: - Properties
    
    let realm = try! Realm()
    
    var bookmarks: Results<Bookmark>?
    
    var movies:[Movie] = []
    
    var bookmarksCount:Int = 0
    var movieCount: Int = 0
    
    let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: BookmarkTableViewCell.identifier)
        return tableView
    }()
    
    private let headerView = BookmarkHeaderUIView()
   
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        addViews()
        setConstraints()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("BookmarkViewController - viewWillAppear")
        
        loadBookmarks()
        
        let headerLabel = headerView.headerLabel
        setUserName(username: headerLabel)
    }

    // MARK: - Handlers
    
    func setUp() {
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        headerView.backgroundColor = .systemBackground
        
    }
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        tableViewConstraints()
        headerViewConstraints()
    }
    
    
    func loadBookmarks() {
        
        bookmarks = realm.objects(Bookmark.self).sorted(byKeyPath: "date", ascending: false)
        
        self.bookmarksCount = bookmarks?.count ?? 0
        self.movieCount = movies.count
        
        if self.bookmarksCount == self.movieCount {
            tableView.reloadData()
            
        } else if self.bookmarksCount == 0 {
            self.movies.removeAll()
            tableView.reloadData()
            
        } else {
            self.movies.removeAll()
            
            for i in 0...bookmarksCount-1 {
                guard let movieId = bookmarks?[i].movieId else { return }
                getMovieDetail(movieId: movieId)
            }
            
        }

    }

    func getMovieDetail(movieId:Int){
        let endPoint:String = "https://api.themoviedb.org/3/movie/\(movieId)"
        let apiKey = Storage().apiKey
        
        let params:Parameters = ["api_key":apiKey, "language":"ko-KR"]
        let request = AF.request(endPoint, method: .get, parameters: params)
        request.responseDecodable(of: Movie.self) { response in
            switch response.result{
            case.failure(let error):
                print(error.errorDescription)
            case.success(let movie):
                self.movies.append(movie)

                if self.movies.count >= self.bookmarksCount{
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            }
        }
    }
    
    func setUserName(username: UILabel) {
        
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            username.text = "\(nickname) 의 보고싶은 영화"
            
        } else {
            username.text = "닉네임을 등록하고 보고싶은 영화를 추가해보세요!"
        }
    }
    
    // MARK: - Constraints
    
    private func tableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func headerViewConstraints() {
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
    }
}

    // MARK: - TableViewDelegate, TableViewDataSource

extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkTableViewCell.identifier, for: indexPath) as? BookmarkTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = self.movies[indexPath.row]
        let movieId = movie.id
        
        let posterPath = movie.posterPath
        let posterFullPath = "\(posterBaseURL)\(posterPath)"
        let posterView = cell.posterView as UIImageView
        posterView.sd_setImage(with: URL(string: posterFullPath), completed: nil)
        
        let title = movie.title
        let titleLabel = cell.titleLabel as UILabel
        titleLabel.text = "\(title)"
        
        let originalTitle = movie.originalTitle
        let originalTitleLabel = cell.originalTitleLabel as UILabel
        originalTitleLabel.text = "\(originalTitle)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard =  UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoView") as! MovieInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.movie = movies[indexPath.row]
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let bookmarkDeleted = bookmarks?[indexPath.row] else { return }
            movies.remove(at: indexPath.row)
            
            do{
                try realm.write {
                    realm.delete(bookmarkDeleted)
                }
            } catch {
                print("Error deleting movie: \(error)")
            }
            
            tableView.reloadData()
        }
        
        
    }
    
    
    
    
    
    
}
