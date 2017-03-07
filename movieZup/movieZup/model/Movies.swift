//
//  Movies.swift
//  movieZup
//
//  Created by Jean Carlos on 2/4/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import Foundation

class Movies : NSObject, NSCoding {
    let title:String
    let year:String
    let rated: String
    let genre: String
    let director: String
    let plot: String //Enrredo, descrição.
    let poster: String
    let type:String
    
    init(title:String, year:String, rated:String, genre:String, director:String, plot:String, poster:String, type:String) {
        self.title = title
        self.year = year
        self.rated = rated
        self.genre = genre
        self.director = director
        self.plot = plot
        self.poster = poster
        self.type = type
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(year, forKey: "year")
        aCoder.encode(rated, forKey: "rated")
        aCoder.encode(genre, forKey: "genre")
        aCoder.encode(director, forKey: "director")
        aCoder.encode(plot, forKey: "plot")
        aCoder.encode(poster, forKey: "poster")
        aCoder.encode(type, forKey: "type")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey : "title") as! String
        self.year = aDecoder.decodeObject(forKey : "year") as! String
        self.rated = aDecoder.decodeObject(forKey : "rated") as! String
        self.genre = aDecoder.decodeObject(forKey : "genre") as! String
        self.director = aDecoder.decodeObject(forKey : "director") as! String
        self.plot = aDecoder.decodeObject(forKey : "plot") as! String
        self.poster = aDecoder.decodeObject(forKey : "poster") as! String
        self.type = aDecoder.decodeObject(forKey : "type") as! String
    }
}


