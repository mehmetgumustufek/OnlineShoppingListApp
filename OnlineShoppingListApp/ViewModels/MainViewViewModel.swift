//
//  MainViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
//import FirebaseAuth
//import FirebaseFirestore
//import Foundation
//class MainViewViewModel: ObservableObject{
//    @Published var currentUserId: String=""
//    var followingUserId: String?
//    var id0: String=""
//    init(){
//        Auth.auth().addStateDidChangeListener{[weak self] _, user in
//            DispatchQueue.main.async {
//                self?.currentUserId = user?.uid ?? ""
//            }
//        }
//        getFollowingUserId{followingId in
//            if let id=followingId{
//                self.id0=id
//            }
//        }
//        followingUserId=id0
//        print(followingUserId)
//        
//    }
//    public var isSignedIn: Bool{
//        return Auth.auth().currentUser != nil
//    }
//    func getFollowingUserId(completion: @escaping (String?)->Void){
//        currentUserId = Auth.auth().currentUser?.uid ?? "idYok"
//        let db = Firestore.firestore()
//        let userCollection = db.collection("users").document(currentUserId)
//        userCollection.getDocument{ (snapshot, error) in
//            guard let data = snapshot?.data(), error == nil else{
//                return
//            }
//            var denemeId=data["following"] as? [String]
//            
//            DispatchQueue.main.async{
//                completion(denemeId?.first)
//                
//            }
//        }
//        
//    }
//    
//}
import FirebaseAuth
import FirebaseFirestore
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    @Published var followingUserId: String = "thereIsNoFollowingUser"
    @Published var username: String = ""
    

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
                self?.fetchFollowingUserId()
                self?.fetchUsername()
                
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func fetchFollowingUserId() {
        getFollowingUserId { [weak self] followingId in
            if let id = followingId {
                DispatchQueue.main.async {
                    self?.followingUserId = id
                }
            }
        }
    }
    func fetchUsername(){
        getUsername{ [weak self] username in
            if let name = username{
                DispatchQueue.main.async {
                    self?.username = name
                }
            }
            
        }
    }

    func getFollowingUserId(completion: @escaping (String?) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }

        let db = Firestore.firestore()
        let userCollection = db.collection("users").document(currentUserId)
        userCollection.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                completion(nil)
                return
            }
            
            let denemeId = data["following"] as? [String]
            completion(denemeId?.first)
        }
    }
    func getUsername(completion: @escaping (String?)->Void){
        guard let currentUserId = Auth.auth().currentUser?.uid else{
            completion(nil)
            return
        }
        let db = Firestore.firestore()
        let userCollection = db.collection("users").document(currentUserId)
        userCollection.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                completion(nil)
                return
            }
            let username = data["name"] as? String
            self.username = username!
            completion(username)
        }
    }
}
