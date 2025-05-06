//
//  movieCollectionViewCell.swift
//  Arc
//
//  Created by Ahmed El Gndy on 04/05/2025.
//
import UIKit

class MovieSearchCollectionViewCell: UICollectionViewCell {
    //MARK: -Properties
    static let reuseIdentifier = "searchCell"
    
    private let moviePosterImageView = DataLoadingImageView()
    private var imageTask: Task<(), Never>?
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Configurtion
    func configureUI() {
        contentView.addSubview(moviePosterImageView)
        moviePosterImageView.pinToEdges(of: contentView)
        moviePosterImageView.layer.cornerRadius = 5
        moviePosterImageView.clipsToBounds = true
    }
    
    //MARK: set cell
    func set(with movie: Movie) {
        guard let moviePath = movie.poster_path else { return }
        
        if let cachedImage = ImageCacheManager.shared.image(for: moviePath) {
            moviePosterImageView.image = cachedImage
        } else {
            loadImage(from: moviePath)
        }
    }
    
    
    private func loadImage(from path: String) {
        imageTask = Task {
            // Cancel if the task is canceled
            if Task.isCancelled { return }
            
            guard let image = await NetworkManager.shared.downloadImage(from: path, imageQuality: .posterWidth154) else { return }
            
            ImageCacheManager.shared.cache(image, forkey: path)
            moviePosterImageView.image = image
        }
    }
    
    
    // MARK: - Reuse Handling
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
        imageTask?.cancel()
        imageTask = nil
    }
}
