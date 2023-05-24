//
//  NBAModel.swift
//  NBA-Stat-Getter
//
//  Created by Uriya Sabah on 5/23/23.
//

import Foundation
import UIKit

class NBAModel{
    
    func getPlayerID(playerNameInput: String?) throws -> String{
        guard let playerName = playerNameInput?.trimmingCharacters(in: .whitespaces).lowercased() else{
            throw RequestError.EmptyText
        }
        if let player_id = playerNameToIds[playerName]{
            return player_id
        }
        else{
            throw RequestError.PlayerNotFound
        }
    }
    
    //Get NBA Player Info
    func searchPlayerByName(playerNameInput: String?) async throws -> String {
        guard let playerName = playerNameInput?.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "%20") else{
            throw RequestError.EmptyText
        }
        
        let urlString = "https://www.balldontlie.io/api/v1/players?search=\(playerName)"
        
        guard let url = URL(string: urlString) else {
            throw RequestError.BadURL
        }
        
        do {
            let data = try await fetchData(from: url)
            //parse the JSON response
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let playerData = json["data"] as? [[String: Any]] {
                //retrieve the first player in the search results
                guard let player = playerData.first, let player_id = player["id"] as? Int else{
                    throw RequestError.PlayerNotFound
                }
                
                return "\(player_id)"
            } else {
                throw RequestError.BadData
            }
        } catch {
            throw RequestError.BadData
        }
    }
    
    //retrieve the player's image using their player id
    func getPlayerImage(playerId: String) async throws -> UIImage{
        let urlString = "https://ak-static.cms.nba.com/wp-content/uploads/headshots/nba/latest/260x190/\(playerId).png"

        guard let url = URL(string: urlString) else {
            throw RequestError.BadURL
        }

        var img: UIImage?

        do{
            let data = try await fetchData(from: url)
            if let image = UIImage(data: data) {
                img = image
            }
        } catch {
            throw error
        }

        guard let image = img else{
            throw RequestError.ImageNotFound
        }
        return image
    }
    
    //retrieve data from a given URL
    func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    //returns 5 similar results from the user's search text to the player names
    func getMatchingResults(text: String) -> [String]{
        var results : [String] = []
        for player in player_names {
            //check if player contains the text
            if player.localizedStandardContains(text) && player != text{
                results.append(player)
            }
            // Limit the number of results to 5
            if results.count == 5 {
                break
            }
        }
        
        return results
    }
    
}
