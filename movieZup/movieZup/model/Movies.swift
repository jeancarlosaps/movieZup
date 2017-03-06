//
//  Movies.swift
//  movieZup
//
//  Created by Jean Carlos on 2/4/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

/*
 Resultado da API:
 
{"Title":"Batman","Year":"1989","Rated":"PG-13","Released":"23 Jun 1989","Runtime":"126 min","Genre":"Action, Adventure","Director":"Tim Burton","Writer":"Bob Kane (Batman characters), Sam Hamm (story), Sam Hamm (screenplay), Warren Skaaren (screenplay)","Actors":"Michael Keaton, Jack Nicholson, Kim Basinger, Robert Wuhl","Plot":"The Dark Knight of Gotham City begins his war on crime with his first major enemy being the clownishly homicidal Joker.","Language":"English, French","Country":"USA, UK","Awards":"Won 1 Oscar. Another 9 wins & 22 nominations.","Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTYwNjAyODIyMF5BMl5BanBnXkFtZTYwNDMwMDk2._V1_SX300.jpg","Metascore":"69","imdbRating":"7.6","imdbVotes":"277,267","imdbID":"tt0096895","Type":"movie","Response":"True"}
*/
import Foundation

struct Movies{
    let title:String
    let year:String
    let rated:String
    let genre:String
    let director:String
    let plot:String //Enrredo, descrição.
    let poster:String
    let type:String
}

enum SerializationError:Error{
    case missing(String)
}

extension Movies{
    init?(json:[String:Any]) throws {
        guard let title = json["Title"] as? String else{
            throw SerializationError.missing("Title")
        }
        
        guard let year = json["Year"] as? String else{
            throw SerializationError.missing("Year")
        }
        
        guard let rated = json["Rated"] as? String else{
            throw SerializationError.missing("Rated")
        }
        
        guard let genre = json["Genre"] as? String else{
            throw SerializationError.missing("Genre")
        }
        
        guard let director = json["Director"] as? String else{
            throw SerializationError.missing("Director")
        }
        
        guard let plot = json["Plot"] as? String else{
            throw SerializationError.missing("Plot")
        }
        
        guard let poster = json["Poster"] as? String else{
            throw SerializationError.missing("Poster")
        }
        
        guard let type = json["Type"] as? String else{
            throw SerializationError.missing("Type")
        }
        
        self.title = title
        self.year = year
        self.rated = rated
        self.genre = genre
        self.director = director
        self.plot = plot
        self.poster = poster
        self.type = type
    }
}

//class Movies{
//    let title:String
//    let year:String
//    let rated: String
//    let genre: String
//    let director: String
//    let plot: String //Enrredo, descrição.
//    let poster: String
//    let type:String
//    
//    init(title:String, year:String, rated:String, genre:String, director:String, plot:String, poster:String, type:String) {
//        self.title = title
//        self.year = year
//        self.rated = rated
//        self.genre = genre
//        self.director = director
//        self.plot = plot
//        self.poster = poster
//        self.type = type
//    }
//}


