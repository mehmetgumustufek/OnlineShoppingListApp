//
//  StorageService.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 17.05.2024.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseAuth

class StorageService{
    
    static var storage = Storage.storage()
    static var storageRoot = storage.reference(forURL: "gs://onlineshoppinglistapp.appspot.com/profile_Image")
    
    static var storageProfile = storageRoot.child("profile_Image")
    
    static func storageProfileId(userId: String) -> StorageReference{
        return storageProfile.child(userId)
    }
    
}
