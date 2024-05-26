//
//  CommonNewItemViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 24.05.2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
class CommonNewItemViewViewModel: ObservableObject{
    @Published var title=""
    @Published var dueDate=""
    @Published var showAlert=false
    
    init(){}
    
    
    func save(followingUserId: String){
        
        guard canSave else{
            return
        }
        let newItemId=UUID().uuidString
        let newItem=TakenListItem(id: newItemId, title: title, isDone: false)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(followingUserId)
            .collection("willBeTaken")
            .document(newItemId)
            .setData(newItem.asDictionary())
        
        
    }
    
    var canSave: Bool{
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        return true
    }
}
