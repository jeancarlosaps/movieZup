//
//  ViewController.swift
//  movieZup
//
//  Created by Jean Carlos on 2/4/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var searchMovie: UISearchBar!
    @IBOutlet weak var tableViewMovie: UITableView!
    
    //MARK: Properties
    var arrayMovieList = [Movies]()
    let moviesForSearch = "Batman"
    
    //Função que faz o request na API do github;
        func request() {
            typealias RepoMovies = [String:Any]
            let repoUrlString = "http://www.omdbapi.com/?t=\(moviesForSearch)&y=&plot=short&r=json"
    
            let session = URLSession.shared
            (session.dataTask(with: URL(string:repoUrlString)!) { [weak self] (data, reponse, error) in
    
                //MARK: Tratamento de erro;
                guard error == nil else { return }
    
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? RepoMovies {
    
                        // O array de repositórios se encontra na chave "itens" do JSON, portanto, precisamos pegá-lo antes;
                        guard let moviesJson = json[""] as? [RepoMovies] else { return }
    
                        do {
                            self?.arrayMovieList = try moviesJson.flatMap(Movies.init)
    
                            DispatchQueue.main.async {
                                self?.tableViewMovie.reloadData()
                            }
                        } catch let error {
                            print(error)
                        }
                    } else {
                        print("Wrong format")
                    }
                } catch let error {
                    print(error)
                }
            }).resume()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableViewMovie.dataSource = self
        self.tableViewMovie.delegate = self
        
//        let time = NSDate().timeIntervalSince1970.description
//        print(time)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Funções
    func presentAlert() {
        let alertController = UIAlertController(title: "Register movie?", message: "Please input movie name:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields?[0] {
                // store your data
                UserDefaults.standard.set(field.text, forKey: "movieName")
                UserDefaults.standard.synchronize()
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
    
    //MARK: Métodos de UITbableViewDataSource e UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let myObject:Movies = arrayMovieList[indexPath.row] as Movies
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: NSURL(string: myObject.poster) as! URL)
            DispatchQueue.main.async {
                cell.posterMovie.image = UIImage(data: data!)
            }
        }
        
        cell.titleMovie.text = arrayMovieList[indexPath.row].title
        cell.yearMovie.text = arrayMovieList[indexPath.row].year
        
//        cell.posterMovie.image = UIImage(named:"iOSwift.jpeg")
//        cell.titleMovie.text = "Swift - The Best Language of Programming"
//        cell.yearMovie.text = "2013"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return meuArray.count
    }
    
    //MARK: Actions
    @IBAction func addMovie(_ sender: UIButton) {
        presentAlert()
    }
}

