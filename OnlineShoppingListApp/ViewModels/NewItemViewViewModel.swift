//
//  NewItemViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
class NewItemViewViewModel: ObservableObject{
    @Published var title=""
    @Published var dueDate=""
    @Published var showAlert=false
    @Published var isDoneByWho=""
    init(){}
    
    
    func save(){
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        guard canSave else{
            return
        }
        let newItemId=UUID().uuidString
        let newItem=TakenListItem(id: newItemId, title: title, isDone: false,isDoneByWho: isDoneByWho)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
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
