//
//  ChoicesTableViewController.swift
//  MoiveNightChoices
//
//  Created by curtis scott on 30/08/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class ChoicesTableViewController: UITableViewController {
    
    enum Choice {
        case PlayerOne
        case PlayerTwo
    }
    
    weak var mainMenu:ViewController?
    var genres = [GenreViewModel]()
    var choser: Choice?
    var picks = 0
    
    //coutlets
    
    
    @IBOutlet weak var confirmChoicesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let menu = mainMenu , let gen = menu.genres  {
            genres = gen
            print("here")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return genres.count 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choice", for: indexPath)
        if genres.count > 0 {
        cell.textLabel?.text = genres[indexPath.row].name
        if genres[indexPath.row].isChosen {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        }
        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if picks >= 3 && !genres[indexPath.row].isChosen {
            displayToMuchChoicesAlert(text: "To Much Chocies")
        }else{
            
        if genres.count > 0 {
             genres[indexPath.row].choseGenre()
            if genres[indexPath.row].isChosen {
                picks+=1
            }  else {
                picks -= 1
            }
            tableView.reloadData()
        }
            
        }
    }
    
    
    //actions
    
    @IBAction func confirmChoices(_ sender: Any) {
        
        if picks == 0 {
            displayToMuchChoicesAlert(text: "No Choices Chosen")
        } else {
        var tempChoices = [GenreViewModel]()
        for model in genres{
            if model.isChosen {
                tempChoices.append(model)
            }
        }
        self.mainMenu!.pickedGenres = tempChoices
            if choser == .PlayerOne {
                self.mainMenu!.playerOneIsDecided = true
            } else {
                self.mainMenu!.playerTwoIsDecided = true
            }
        
        print(self.mainMenu!.playerOneIsDecided)
        self.mainMenu!.checkIfPlayerHasChosen()
            print(self.mainMenu!.readyToSendGenres)
        self.navigationController?.popViewController(animated: true)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ChoicesTableViewController {
    
    
    //helpers
    
    
    func displayToMuchChoicesAlert(text:String){
        
        let alert = UIAlertController(title: text, message: "Please choose 1 to 3 choices", preferredStyle: .alert)
        let action  = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
        
        
    }
}
