//
//  RegisterViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

class RegisterViewViewModel: ObservableObject{
    @Published var name=""
    @Published var email=""
    @Published var password=""
    @Published var followingCount=0
    @Published var followersCount=0
    @Published var followers:[String]?
    @Published var following:[String]?
    @Published var searchname: [String]?
    @Published var errorMessage=""
    init(name: String = "", email: String = "", password: String = "") {
        self.name = name
        self.email = email
        self.password = password
        
    }
    func register(){
        guard validate() else{
            return
        }
        Auth.auth().createUser(withEmail: email, password: password){
            [weak self] result, error in
            guard let userId=result?.user.uid else{
                return
                
            }
            self?.insertUserRecord(id: userId)
        }
        
    }
    private func insertUserRecord(id: String){
        //firestore a istek atma
        searchname = name.splitString()
        followers = []
        following = []
        let newUser=User(id: id, name: name, searchname: searchname, email: email,joined: Date().timeIntervalSince1970, followersCount: followersCount,followingCount: followingCount,followers: followers, following: following)
        let db=Firestore.firestore()
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool{
        errorMessage=""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
                errorMessage="Lütfen tüm alanları doldurunuz!"
                return false
        }
        guard email.contains("@") && email.contains(".") else{
            errorMessage="Lütfen geçerli bir email adresi giriniz!"
            return false
        }
        guard password.count >= 6 else{
            errorMessage="Lütfen 6 veya daha fazla uzunlukta bir şifre giriniz!"
            return false
        }
        return true
    }
}
