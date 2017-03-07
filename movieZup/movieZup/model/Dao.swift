//
//  Dao.swift
//  movieZup
//
//  Created by Marcos Lacerda on 07/03/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import Foundation

class Dao {
    let moviesArchive : String
    
    init() {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let directory = userDirs[0]
        
        moviesArchive = "\(directory)/movie-zup.data"
    }
    
    func save(_ movies : Array<Movies>) {
        NSKeyedArchiver.archiveRootObject(movies, toFile: moviesArchive)
    }
    
    func load() -> Array<Movies> {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: moviesArchive) {
            let movies = loaded as! Array<Movies>
            
            return movies
        }
        
        return []
    }
}
