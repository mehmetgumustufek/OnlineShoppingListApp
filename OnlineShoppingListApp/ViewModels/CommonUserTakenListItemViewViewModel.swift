//
//  CommonUserTakenListItemViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 24.05.2024.
//

import Foundation
import FirebaseFirestore
import Firebase
class CommonUserTakenListItemViewViewModel: ObservableObject{
    init(){}
    func toggleIsDone(item: TakenListItem,followingUserId: String,username: String){
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        if(!item.isDone==true){
            itemCopy.setUsername(username: username)
        }else{
            itemCopy.setUsername(username: "")
        }
        
        let db=Firestore.firestore()
        db.collection("users")
            .document(followingUserId)
            .collection("willBeTaken")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
