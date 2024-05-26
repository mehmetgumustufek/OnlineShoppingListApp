//
//  SearchService.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 17.05.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

class SearchService{
    static func searchUser(input: String, onSuccess: @escaping(_ user: [User])->Void){
        AuthService.storeRoot.collection("users").whereField("searchname", arrayContains: input.lowercased().removeWhiteSpace()).getDocuments{
            (QuerySnapshot, err) in
            
            guard let snapshot = QuerySnapshot else{
                print("error")
                return
            }
            var users = [User]()
            for document in snapshot.documents{
                let dict = document.data()
                
                guard let decoded = try? User.init(fromDictionary: dict) else {return}
                if decoded.id != Auth.auth().currentUser!.uid{
                    users.append(decoded)
                }
                onSuccess(users)
            }
        }
//
//        if let currentUser=Auth.auth().currentUser{
//            let uid = currentUser.uid
//            
//            let db = Firestore.firestore()
//            
//            let userReference = db.collection("users").document(uid)
//            
//            userReference.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let userData = document.data()
//                    let searchname = userData?["searchname"] as? [String]
//                } else {
//                    print(error?.localizedDescription ?? "bilinmeyen hata oluştu")
//                }
//            }
//        }
    }
}
