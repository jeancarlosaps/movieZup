//
//  DetailMovieViewController.swift
//  movieZup
//
//  Created by Marcos Lacerda on 07/03/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import UIKit
import SDWebImage

class DetailMovieViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var titleMovieDetail: UILabel!
    @IBOutlet weak var yearMovieDetail: UILabel!
    @IBOutlet weak var genreMovieDetail: UILabel!
    @IBOutlet weak var posterMovieDetail: UIImageView!
    @IBOutlet weak var directorMovieDetail: UILabel!
    @IBOutlet weak var plotMovieDetail: UITextView!

    var movieDetail : Movies!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleMovieDetail.text = movieDetail.title
        yearMovieDetail.text = movieDetail.year
        genreMovieDetail.text = movieDetail.genre
        directorMovieDetail.text = movieDetail.director
        plotMovieDetail.text = movieDetail.plot
        
        posterMovieDetail.setShowActivityIndicator(true)
        posterMovieDetail.setIndicatorStyle(.gray)
        
        let photoURL = URL(string: movieDetail.poster)
        posterMovieDetail.sd_setImage(with: photoURL)
    }

}
