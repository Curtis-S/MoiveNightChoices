//
//  ResultsTableViewController.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 30/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    weak var mainMenu:MenuViewController?
    var results:[Movie]?
    
    //outlets
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activitySpinner.startAnimating()
        self.loadResults()

     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
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
    
    
   
    
    @IBAction func finishedResults(_ sender: Any) {
        
        displayClosingAlert(title: "Finished", message: "if you want to reset app click yes else click no")
    }
    
    
// helpers
    
    
    func displayClosingAlert(title:String,message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action  = UIAlertAction(title: "no", style: .cancel, handler: nil)
        let actionT  = UIAlertAction(title: "yes", style: .destructive, handler: alertHandler)
        alert.addAction(action)
        alert.addAction(actionT)
        self.present(alert, animated: true)
        
        
    }
    
   private func alertHandler(alert: UIAlertAction!) {
    mainMenu!.resetApp()
    dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func loadTableResults(){
        
        if results != nil {
            activitySpinner.hidesWhenStopped = true
            activitySpinner.stopAnimating()
        }
        self.tableView.reloadData()
    }
    
    
    func loadResults(){
        print("start load fucnthion ")
        if let menu = mainMenu {
             print("menu is here  ")
            let endpoint = MoviesDB.search(ids: menu.readyToSendGenres)
            print(endpoint.request)
            menu.client.getReleventDataRequest(with: endpoint, type: Movies.self){ [weak self] films , error in
                guard let self = self else{
                    return
                }
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
