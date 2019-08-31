//
//  ViewController.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 30/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var playerOneIsDecided = false
    var playerTwoIsDecided = false
    var genres :[GenreViewModel]?
    var pickedGenres:[GenreViewModel]?
    var readyToSendGenres: [Int]  {
        var retSet: [Int] = []
        for model in pickedGenres! {
            retSet.append(model.id)
        }
        let set =  Set(retSet)
        return Array(set)
    }
    
    //outlets
    @IBOutlet weak var playerOneStart: UIImageView!
    
    @IBOutlet weak var playerOneButton: UIButton!
    
    @IBOutlet weak var playerTwoButton: UIButton!
    
    @IBOutlet weak var showResultsButton: UIButton!
    
    let client = MovieDBApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let endpoint = MoviesDB.genre
        let searchEndpoint = MoviesDB.search(ids: [18,28,36])
        print(searchEndpoint.request.url!)
        print("********************************")
        print(endpoint.request.url!)
        
       showResultsButton.layer.cornerRadius = 5
       showResultsButton.layer.borderWidth = 1
        
        checkIfPlayerHasChosen()
        client.getReleventDataRequest(with: endpoint, type: Genres.self) { genres , error in
            
            guard let gen = genres else {
                return
            }
            var tempArray = [GenreViewModel]()
            for genre in gen.genres {
                tempArray.append(GenreViewModel(genre: genre))
            }
            self.genres = tempArray
            
            print("done")
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
        
        
      
        
    }


    
    
    //actions
    
    
    @IBAction func showResults(_ sender: Any) {
        
        
    }
    
    
    
    // helper methods
    
    
    
    func checkIfPlayerHasChosen(){
        if playerOneIsDecided{
            playerOneButton.isEnabled = false
           
            playerOneButton.setImage(UIImage(named: "bubble-selected"), for: .disabled)
        } else {
            playerOneButton.isEnabled = true
            playerOneButton.setImage(UIImage(named: "bubble-empty"), for: .normal)
            
           
            
        }
        
        if playerTwoIsDecided{
            playerTwoButton.isEnabled = false
            
            playerTwoButton.setImage(UIImage(named: "bubble-selected"), for: .disabled)
        } else {
            playerTwoButton.isEnabled = true
            playerTwoButton.setImage(UIImage(named: "bubble-empty"), for: .normal)
            
        }
        
        
        if playerOneIsDecided && playerTwoIsDecided {
            showResultsButton.isHidden = false
        } else {
            showResultsButton.isHidden = true
        }
        
    }
    
    
    
    
    // navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showPlayerOneChoice" {
            let choiceVc = segue.destination as? ChoicesTableViewController
            choiceVc?.mainMenu = self
            choiceVc?.choser = .PlayerOne
            
            
            
        } else if segue.identifier == "showPlayerTwoChoice" {
            
            let choiceVc = segue.destination as? ChoicesTableViewController
            choiceVc?.mainMenu = self
            choiceVc?.choser = .PlayerTwo
            
            
            
        } else if segue.identifier == "showResults" {
            let navVC = segue.destination as? UINavigationController
            let resultsVc = navVC?.topViewController as? ResultsTableViewController
            resultsVc?.mainMenu = self
            
            
            
            
        }
        
    }
    
    
    
    
}


extension ViewController {
    
    
    //helper
    
    
    func checkIfChanges (){
        
    }
}




