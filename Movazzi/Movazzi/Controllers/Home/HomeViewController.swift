//
//  HomeViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/14.
//

import UIKit
import Alamofire
import SDWebImage


class HomeViewController: UIViewController {
    // MARK: - Properties
    
    let genres: [String] = ["공포", "코미디", "로맨스", "애니메이션" ,"SF/액션", "드라마", "음악", "다큐멘터리", "전쟁", "역사"]
    let engGenres: [String] = ["horror", "comic", "romance", "animation", "action", "drama", "music", "documentary", "war", "history"]
    
    let genreIds = [27, 35, 10749, 16, 878, 18, 10402, 99, 10752, 36]
    
    var movies:[Movie]?
    let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "영화 검색하기"
        return searchBar
    }()
    
    let genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        return collectionView
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let boxOfficeHeaderlabel: UILabel = {
        let label = UILabel()
        label.text = "BOX OFFICE"
        label.font = UIFont(name: "HCR Dotum Bold", size: 23.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let boxOfficeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addViews()
        setConstraints()
        
        boxOffice()
        
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
    }
    // MARK: - Handlers
    
    private func setUp() {
        configureGenreCollectionView()
        configureBoxOfficeCollectionView()
    }
    
    private func configureGenreCollectionView() {
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
    }
    
    private func configureBoxOfficeCollectionView() {
        boxOfficeCollectionView.delegate = self
        boxOfficeCollectionView.dataSource = self
    }
    
    func addViews() {
        view.addSubview(genreCollectionView)
        view.addSubview(borderView)
        view.addSubview(boxOfficeHeaderlabel)
        view.addSubview(boxOfficeCollectionView)
    }
    
    func setConstraints() {
        genreCollectionViewConstraints()
        borderViewConstraints()
        boxOfficeHeaderLabelConstraints()
        boxOfficeCollectionViewConstraints()
    }
    
    func boxOffice(){
        let endPoint = "https://api.themoviedb.org/3/movie/now_playing?page="
        let apiKey = Storage().apiKey
        let params:Parameters = ["api_key":apiKey, "language":"ko-KR", "page":1]
        
        let request = AF.request(endPoint, method: .get, parameters: params)
        request.responseDecodable(of: MovieInfo.self) { response in
            switch response.result{
            case .failure(let error):
                print(error.errorDescription)
            case.success(let movieInfo):
                self.movies = movieInfo.results
    
                DispatchQueue.main.async {
                    self.boxOfficeCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Constraints
    
    private func genreCollectionViewConstraints() {
        genreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        genreCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60).isActive = true
        genreCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        genreCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        genreCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func borderViewConstraints() {
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        borderView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        borderView.topAnchor.constraint(equalTo: genreCollectionView.bottomAnchor).isActive = true
        
    }
    
    private func boxOfficeHeaderLabelConstraints() {
        boxOfficeHeaderlabel.translatesAutoresizingMaskIntoConstraints = false
        boxOfficeHeaderlabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        boxOfficeHeaderlabel.topAnchor.constraint(equalTo: borderView.bottomAnchor, constant: 20).isActive = true
        boxOfficeHeaderlabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30).isActive = true
    }
    
    private func boxOfficeCollectionViewConstraints() {
        boxOfficeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        boxOfficeCollectionView.topAnchor.constraint(equalTo: boxOfficeHeaderlabel.bottomAnchor, constant: 15).isActive = true
        boxOfficeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        boxOfficeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        boxOfficeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}


    // MARK: - CollectionViewDelegate, CollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == genreCollectionView {
            return genres.count
        } else {
            
            if let movies = self.movies {
                return movies.count
            } else {
                return 0
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == genreCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let engGenre = engGenres[indexPath.row]
            let imageName = "genre-\(engGenre)"
            cell.genreImageView.image = UIImage(named: imageName)
            
            let genre = genres[indexPath.row]
            cell.titleLabel.text = genre
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeCollectionViewCell.identifier, for: indexPath) as? BoxOfficeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            guard let movies = self.movies else {
                return cell
            }
            
            let movie = movies[indexPath.row]
            
            let posterPath = movie.posterPath
            let posterFullPath = "\(posterBaseURL)\(posterPath)"
            cell.posterView.sd_setImage(with: URL(string: posterFullPath), completed: nil)
            
//            let title = genres1[indexPath.row]
//            cell.titleLabel.text = "\(title) 영화"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == genreCollectionView {
            let storyboard =  UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GenreView") as! GenreViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            let genres = self.genres
            vc.genre = genres[indexPath.row]
            
            let genreIds = self.genreIds
            vc.genreId = genreIds[indexPath.row]
        } else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoView") as! MovieInfoViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
            guard let movies = self.movies else { return }
            vc.movie = movies[indexPath.row]
            
        }
        
    }
}

    // MARK: - CollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    // 셀의 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == genreCollectionView {
            let collectionViewWidth = collectionView.bounds.width
            let cellWidth = (collectionViewWidth - 80) / 5
            let cellHeight = cellWidth + 30
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let cellHeight = collectionView.bounds.height
            let cellWidth = cellHeight * 0.6
            let size = CGSize(width: cellWidth, height: cellHeight)
            
            return size
        }
    }
    // 셀의 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // 셀의 열 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == genreCollectionView {
            return UIEdgeInsets()
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
    
}


// MARK: - SearchBarDelegate
extension HomeViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let storyboard =  UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchView") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        searchBar.resignFirstResponder()
    }
    
}
