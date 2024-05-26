//
//  AuthService.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 17.05.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthService{
    
    static var storeRoot = Firestore.firestore()
    static func getUserId(userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
    
    
}
