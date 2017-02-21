//
//  Movies.swift
//  movieZup
//
//  Created by Jean Carlos on 2/4/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import Foundation

class Movies{
    let title:String
    let year:String
    let imdbID:String
    let type:String
    let detail:String
    let pictures:String
    
    init(title:String, year:String, imdbID:String, type:String, detail:String, pictures:String) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.detail = detail
        self.pictures = pictures
    }
}
    

