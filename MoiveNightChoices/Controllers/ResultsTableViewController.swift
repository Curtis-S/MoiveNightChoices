//
//  ResultsTableViewController.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 30/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    weak var mainMenu:ViewController?
    var results:[Movie]?
    
    //outlet

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activitySpinner.startAnimating()
        self.loadResults()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath)

        // Configure the cell...
        
        if let results = results {
            cell.textLabel?.text = results[indexPath.row].title
            cell.detailTextLabel?.text = results[indexPath.row].overview
        }

        return cell
    }
    
// helpers
    
    func loadTableResults(){
        
        if results != nil {
            activitySpinner.hidesWhenStopped = true
            activitySpinner.stopAnimating()
        }
        self.tableView.reloadData()
    }
    
    
    func loadResults(){
        print("start load fucnthion ")
        print(mainMenu)
        if let menu = mainMenu {
             print("menu is here  ")
            let endpoint = MoviesDB.search(ids: menu.readyToSendGenres)
            print(endpoint.request)
            menu.client.getReleventDataRequest(with: endpoint, type: Movies.self){ films , error in
                
                if let films = films {
                    print("received Data")
                    DispatchQueue.main.async {
                        self.results = films.results
                         print("copied table data")
                        self.loadTableResults()
                        print("loaded tabled")
                    }
                    
                }
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                
                
            }
        }
        
    }

}
