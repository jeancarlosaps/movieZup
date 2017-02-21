//
//  ViewController.swift
//  movieZup
//
//  Created by Jean Carlos on 2/4/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var searchMovie: UISearchBar!
    @IBOutlet weak var tableViewMovie: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let time = NSDate().timeIntervalSince1970.description
        print(time)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func addMovie(_ sender: UIButton) {
    }
    
    


}

