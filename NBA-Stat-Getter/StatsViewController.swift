//
//  StatsViewController.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/24/23.
//

import Foundation
import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var reboundsLabel: UILabel!
    
    @IBOutlet weak var assistsLabel: UILabel!
    
    @IBOutlet weak var trueShootingLabel: UILabel!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var offrtgLabel: UILabel!
    
    @IBOutlet weak var defrtgLabel: UILabel!
    
    @IBOutlet weak var netrtgLabel: UILabel!
    
    @IBOutlet weak var astPercLabel: UILabel!
    
    @IBOutlet weak var astTovRatLabel: UILabel!
    
    @IBOutlet weak var orebPercLabel: UILabel!
    
    @IBOutlet weak var drebPercLabel: UILabel!
    
    @IBOutlet weak var rebPercLabel: UILabel!
    
    @IBOutlet weak var efgPercLabel: UILabel!
    
    @IBOutlet weak var tsPercLabel: UILabel!
    
    @IBOutlet weak var usgPercLabel: UILabel!
    
    @IBOutlet weak var paceLabel: UILabel!
    
    @IBOutlet weak var pieLabel: UILabel!
    
    @IBOutlet weak var possLabel: UILabel!
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    var player_info: [String: Any]?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playerImageView.image = image!
        playerNameLabel.text = player_info?["PLAYER"] as? String
        pointsLabel.text = String(player_info?["PTS"] as! Double)
        reboundsLabel.text = String(player_info?["REB"] as! Double)
        assistsLabel.text = String(player_info?["AST"] as! Double)
        trueShootingLabel.text = String(player_info?["TS%"] as! Double)
        teamNameLabel.text = player_info?["TEAM"] as? String
        offrtgLabel.text = String(player_info?["OFFRTG"] as! Double)
        defrtgLabel.text = String(player_info?["DEFRTG"] as! Double)
        netrtgLabel.text = String(player_info?["NETRTG"] as! Double)
        astPercLabel.text = String(player_info?["AST%"] as! Double)
        astTovRatLabel.text = String(player_info?["AST/TO"] as! Double)
        orebPercLabel.text = String(player_info?["OREB%"] as! Double)
        drebPercLabel.text = String(player_info?["DREB%"] as! Double)
        rebPercLabel.text = String(player_info?["REB%"] as! Double)
        efgPercLabel.text = String(player_info?["EFG%"] as! Double)
        tsPercLabel.text = String(player_info?["TS%"] as! Double)
        usgPercLabel.text = String(player_info?["USG%"] as! Double)
        paceLabel.text = String(player_info?["PACE"] as! Double)
        pieLabel.text = String(player_info?["PIE"] as! Double)
        possLabel.text = String(player_info?["POSS"] as! Double)
        
    }
    
}
