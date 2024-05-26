//
//  TakenListItemViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
class TakenListItemViewViewModel: ObservableObject{
    init(){}
    func toggleIsDone(item: TakenListItem){
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uId = Auth.auth().currentUser?.uid else{
            return
        }
        let db=Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("willBeTaken")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
    
}
