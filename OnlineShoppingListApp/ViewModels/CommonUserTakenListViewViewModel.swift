//
//  CommonUserTakenListViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 21.05.2024.
//

import Foundation
import FirebaseFirestore

class CommonUserTakenListViewViewModel: ObservableObject{
    @Published var showingNewItemView=false
    private let followingUserId: String
    
    init(followingUserId: String) {
        self.followingUserId=followingUserId
    }
    func delete(id: String){
        let db =  Firestore.firestore()
        db.collection("users")
            .document(followingUserId)
            .collection("willBeTaken")
            .document(id)
            .delete()
    }
    func getUsername(){
        
    }
}

