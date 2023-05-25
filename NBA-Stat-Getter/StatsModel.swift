//
//  StatsModel.swift
//  
//
//  Created by Uriya Sabah on 5/24/23.
//

import Foundation
import FirebaseFirestore

class StatsModel{
    func getPlayerInfo(playerName: String) async throws -> [String: Any] {
        let db = Firestore.firestore()
        let docRef = db.collection("players").document(playerName)
        
        do {
            let document = try await docRef.getDocument()
            
            if document.exists {
                if let data = document.data() {
                    return data
                } else {
                    throw StatsError.EmptyDocument
                }
            } else {
                throw StatsError.DocumentNotFound
            }
        } catch {
            throw error
        }
    }
}
