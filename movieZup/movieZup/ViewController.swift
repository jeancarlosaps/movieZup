//
//  ViewController.swift
//  movieZup
//
//  Created by Jean Carlos on 2/4/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import UIKit
import Alamofire

import SDWebImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var searchMovie: UISearchBar!
    @IBOutlet weak var tableViewMovie: UITableView!
    @IBOutlet weak var progress : UIActivityIndicatorView!
    
    //MARK: Properties
    var arrayMovieList = [Movies]()
    var searchActive:Bool = false
    var filtered:[Movies] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayMovieList = Dao().load()
        
        self.tableViewMovie.dataSource = self
        self.tableViewMovie.delegate = self
        self.searchMovie.delegate = self
        
    }
    
    //MARK: Funções
    func presentAlert() {
        let alertController = UIAlertController(title: "Register movie?", message: "Please input movie name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                self.progress.startAnimating()
                self.callAPI(movieName: field.text!)
            } else {
                // user did not fill field
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Movie"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Métodos de UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = arrayMovieList.filter({ (movie) -> Bool in
            let tmp:NSString = movie.title as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false
        }else{
            searchActive = true
        }
        
        self.tableViewMovie.reloadData()
        
    }
    
    //MARK: Métodos de UITbableViewDataSource e UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let movie = arrayMovieList[indexPath.row]
        let photoURL = URL(string: movie.poster)
        
        if(searchActive){
            cell.titleMovie.text = filtered[indexPath.row].title
        }else{            
            cell.titleMovie.text = movie.title
            cell.yearMovie.text = movie.year
            
            cell.posterMovie.setShowActivityIndicator(true)
            cell.posterMovie.setIndicatorStyle(.gray)
            cell.posterMovie.sd_setImage(with: photoURL)
            
            cell.posterMovie.layer.borderWidth = 1
            cell.posterMovie.layer.masksToBounds = true
            cell.posterMovie.layer.borderColor = UIColor.clear.cgColor
            cell.posterMovie.layer.cornerRadius = cell.posterMovie.frame.height / 2
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            return filtered.count
        }
        return arrayMovieList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = arrayMovieList[indexPath.row]
        
        let detailController = DetailMovieViewController()
        
        detailController.movieDetail = movie
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    //MARK: Actions
    @IBAction func addMovie(_ sender: UIButton) {
        presentAlert()
    }
    
    func callAPI(movieName : String) -> Void {
        let baseURL = "http://www.omdbapi.com/?t=\(movieName)&y=&plot=short&r=json"
        let url = baseURL.replacingOccurrences(of: " ", with: "%20")
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                if let json = response.result.value as? [String : Any] {
                    print("JSON: \(json)")
                    
                    let movie = Movies(title: json["Title"] as! String, year: json["Year"] as! String, rated: json["Rated"] as! String, genre: json["Genre"] as! String, director: json["Director"] as! String, plot: json["Plot"] as! String, poster: json["Poster"] as! String, type: json["Type"] as! String)
                    
                    self.arrayMovieList.append(movie)
                    Dao().save(self.arrayMovieList)
                    
                    self.progress.stopAnimating()
                    self.tableViewMovie.reloadData()
                } else {
                    
                }

            case .failure(let error):
                print(error)
            }
        }
    }
}

