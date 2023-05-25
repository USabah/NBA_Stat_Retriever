//
//  homeViewController.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/22/23.
//

import UIKit

class QueryViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var nba_brain : NBAModel = NBAModel()
    var auth_brain : AuthModel = AuthModel()
    var stats_brain : StatsModel = StatsModel()
    
    @IBOutlet weak var playerNameField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var suggestedResults : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //initialize and configure the UITableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        playerNameField.delegate = self
        playerNameField.placeholder = "Enter Player Name"
        playerNameField.autocapitalizationType = .none
        playerNameField.autocorrectionType = .no
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //get the updated text after it changes
        guard let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else{
            return true
        }
        
        //update the suggested results based on the updated text
        let suggestedResults = nba_brain.getMatchingResults(text: updatedText)
        
        updateSuggestedResults(suggestedResults)
        
        //return true to allow the text change, false to prevent it
        return true
    }
    
    func updateSuggestedResults(_ results: [String]){
        suggestedResults = results
        
        //Reload the table view
        tableView.reloadData()
        
        //hide if no results
        tableView.isHidden = results.isEmpty
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return suggestedResults.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = suggestedResults[indexPath.row]
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedResult = suggestedResults[indexPath.row]
            //handle the selected result
            playerNameField.text = selectedResult
            tableView.isHidden = true
        }

    @IBAction func searchButtonPress(_ sender: UIButton) {
        Task {
            do {
                let player_id = try nba_brain.getPlayerID(playerNameInput: playerNameField.text)
                let image = try await nba_brain.getPlayerImage(playerId: player_id)
                let player_name = playerNameField.text!.lowercased()
                var player_info = try await stats_brain.getPlayerInfo(playerName: player_name)
                player_info["PLAYER"] = player_name.uppercased()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let statsViewController = storyboard.instantiateViewController(withIdentifier: "StatsViewController") as! StatsViewController
                statsViewController.player_info = player_info
                statsViewController.image = image
                self.navigationController?.pushViewController(statsViewController, animated: false)
            }
            catch RequestError.EmptyText{
                let myAlert = UIAlertController(title: "Field Is Blank", message: "Please fill in the player name field above.", preferredStyle: .alert)
                myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
            }
            catch RequestError.PlayerNotFound{
                let myAlert = UIAlertController(title: "Player Not Found", message: "Please make sure you inputted the player's name correctly.", preferredStyle: .alert)
                myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
            }
            catch RequestError.BadURL, RequestError.ImageNotFound, RequestError
                .BadData{
                let myAlert = UIAlertController(title: "Player Data Unavailable", message: "Either the data services are currently down, or the player is missing data.", preferredStyle: .alert)
                myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
            }
            catch{
                let myAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(myAlert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signOutButtonPress(_ sender: UIButton) {
        do{
            try auth_brain.userSignOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signInViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            signInViewController.navigationItem.setHidesBackButton(true, animated: false)
            let navigationController = UINavigationController(rootViewController: signInViewController)
            self.view.window?.rootViewController = navigationController
        }
        catch{
            let myAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        }
        
    }
    
    
}
