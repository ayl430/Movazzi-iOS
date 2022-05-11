//
//  SearchViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/17.
//

import UIKit
import Alamofire
import SDWebImage

class SearchViewController: UIViewController {

    // MARK: - Properties
    
    var movies:[Movie]?
    let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = .tintColorYellow
        return searchBar
    }()
   
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUp()
        addViews()
        setConstraints()
        
        customSearchBar()
        customTableView()
    }

    
    // MARK: - Handlers
    
    func setUp() {
        configureSearchBar()
        configureTableview()
    }
    
    private func configureSearchBar() {
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    private func configureTableview() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func addViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func setConstraints() {
        searchBarConstraints()
        tableViewConstraints()
    }
    
    func customSearchBar(){
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "영화 제목을 입력하세요"
        
        searchBar.setImage(UIImage(named: "search"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.setImage(UIImage(named: "clear"), for: .clear, state: .normal)
        searchBar.showsCancelButton = true
    }
    
    func customTableView() {
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    func search(query:String){
        let endPoint = "https://api.themoviedb.org/3/search/movie"
        let apiKey = Storage().apiKey
        let params:Parameters=["api_key":apiKey,"query":query, "language":"ko-KR", "page":1]
        
        let request = AF.request(endPoint, method: .get, parameters: params)
        request.responseDecodable(of: MovieInfo.self) { response in
            switch response.result{
            case.failure(let error):
                print(error)
            case.success(let movieInfo):
                self.movies = movieInfo.results
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Constraints

    private func searchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 56).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    private func tableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
    // MARK: - SearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            search(query:text)
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movies?.removeAll()
        tableView.reloadData()
    }


}


    // MARK: - TableViewDelegate, TableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        
        guard let movies = self.movies else {
            return cell
        }
        
        let movie = movies[indexPath.row]
        
        let posterPath = movie.posterPath
        let posterFullPath = "\(posterBaseURL)\(posterPath)"
        let imageViewPoster = cell.posterView as UIImageView
        imageViewPoster.sd_setImage(with: URL(string: posterFullPath), completed: nil)
        
        let titleLabel = cell.titleLabel as UILabel
        titleLabel.text = movie.title
        
        let originalTitleLabel = cell.originalTitleLabel as UILabel
        originalTitleLabel.text = "\(movie.originalTitle)"
        originalTitleLabel.textColor = .lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard =  UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoView") as! MovieInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        guard let movies = self.movies else { return }
        vc.movie = movies[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
