//
//  TakenListViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation
class TakenListViewViewModel: ObservableObject{
    @Published var showingNewItemView=false
    @Published var followingUserId: String?
    private let userId: String
    init(userId: String) {
        self.userId=userId
    }
    func delete(id: String){
        let db =  Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("willBeTaken")
            .document(id)
            .delete()
    }
}
