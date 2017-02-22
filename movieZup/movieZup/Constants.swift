//
//  Constants.swift
//  movieZup
//
//  Created by Jean Carlos on 2/21/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//
// Gerar API Key: http://beforethecode.com/projects/omdb/apikey.aspx?
/*
 Your API Key:
 
 affee530
 Example:
 
 http://img.omdbapi.com/?i=tt2294629&apikey=affee530
 */

import Foundation

let movieParameter =  "Batman" //Coloquei essa constante aqui, só pra saber que devo montar a URL com esse parâmetro imputado pelo usuário.

struct Constants {
    struct Url {
        static let GetURL = "http://www.omdbapi.com/?t=\(movieParameter)&y=&plot=short&r=json"
        static let GetURLPost = "http://img.omdbapi.com/?i=tt2294629&apikey=affee530"
    }
    
    struct Key {
        static let privateKey = "affee530"
    }
}
