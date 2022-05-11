//
//  GenreViewController.swift
//  Movazzi
//
//  Created by yeri on 2022/03/18.
//

import UIKit
import Alamofire
import SDWebImage

class GenreViewController: UIViewController {
    // MARK: - Properties
    
    var genre:String?
    var genreId:Int?
    
    var movies:[Movie]?
    
    let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    
    let movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.register(GenreHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GenreHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        addViews()
        setConstraints()
        
        getGenreMovie()
        
    }
    
    // MARK: - Handlers
    
    func setUp() {
        configureMovieCollectionView()
    }
    
    func configureMovieCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    
    func addViews() {
        view.addSubview(movieCollectionView)
    
    }
    
    func setConstraints() {
        movieCollectionViewConstraint()
    }
    
    func getGenreMovie() {
        if let genreId = self.genreId {
            getMovies(genreId: genreId, pageNo: 1)
        }
    
    }
    
    func getMovies(genreId:Int, pageNo: Int){
        let EndPoint = "https://api.themoviedb.org/3/discover/movie"
        let apiKey = Storage().apiKey
        let params:Parameters = ["api_key":apiKey, "language":"ko-KR","with_genres":genreId, "page":pageNo]
        
        let request = AF.request(EndPoint, method: .get, parameters: params)
        request.responseDecodable(of: MovieInfo.self) { response in
            switch response.result{
            case .failure(let error):
                print(error.errorDescription)
            case.success(let movieInfo):
                self.movies = movieInfo.results
                
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                }
            }
        }
    }
    
    
    // MARK: - Constraints
    
    private func movieCollectionViewConstraint() {
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}


    // MARK: - CollectionViewDelegate, CollectionViewDataSource

extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let movies = self.movies {
            return movies.count
        } else {
            return 0
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let movies = self.movies else {
            return cell
        }
        
        let movie = movies[indexPath.row]
        
        let posterPath = movie.posterPath
        let posterFullPath = "\(posterBaseURL)\(posterPath)"
        cell.imageView.sd_setImage(with: URL(string: posterFullPath), completed: nil)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoView") as! MovieInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        guard let movies = self.movies else { return }
        vc.movie = movies[indexPath.row]
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: GenreHeaderCollectionReusableView.identifier, for: indexPath) as! GenreHeaderCollectionReusableView
        
        let label = header.label
        label.text = "인기 \(genre ?? " ") 영화"
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 70)
    }
}

    // MARK: - CollectionViewDelegateFlowLayout

extension GenreViewController:
    UICollectionViewDelegateFlowLayout {

    // 셀의 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.width - 60)/2
        let size = CGSize(width: width, height: width*1.5)
        return size
    }

    // 셀의 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    // 셀의 열 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

