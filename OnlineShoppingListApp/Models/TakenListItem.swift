//
//  TakenListItem.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//

import Foundation
struct TakenListItem: Codable, Identifiable{
    let id: String
    let title: String
    var isDone: Bool
    var isDoneByWho: String?
    
    mutating func setDone(_ state: Bool){
        isDone = state
    }
    mutating func setUsername(username: String){
        isDoneByWho=username
    }
}
