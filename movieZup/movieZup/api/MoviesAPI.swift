//
//  MoviesAPI.swift
//  movieZup
//
//  Created by Jean Carlos on 2/4/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import Foundation

class MoviesAPI{
    
    func GetMovies(_ shotURL: String, completation: (([Movies]) -> Void)!) {
        
        let session = URLSession.shared
        let url = URL(string: shotURL)
        
        let task = session.dataTask(with: url!) { (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200){
                if error != nil{
                    print(error!.localizedDescription)
                }else{
                    var error: NSError?
                    do{
                        let contentData: AnyObject = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as AnyObject
                        
                        if let dadosArray = contentData["data"] as? NSMutableDictionary{
                            
                            if let results = dadosArray["results"] as? NSArray{
                                
                                var itensMovies = [Movies]()
                                
                                for item in results{
                                    
                                    //let mv = Movies.
                                    itensMovies.append(mv)
                                }
                                
                                DispatchQueue.main.sync {
                                    completation(itensMovies)
                                }
                            } //Fim let results
                            
                            
                        } //Fim let dadosArray
                    } catch let error1 as NSError{
                        error = error1
                        print("Could not parse JSON: \(error!)")
                    } catch{
                        fatalError()
                    }
                    
                } //Fim else
            } //Fim if statusCode
        })
        task.resume()
    }
    
}
