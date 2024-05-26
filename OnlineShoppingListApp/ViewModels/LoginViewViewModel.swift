//
//  LoginViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
import FirebaseAuth
import Foundation
class LoginViewViewModel: ObservableObject{
    @Published var email=""
    @Published var password=""
    @Published var errorMessage=""
    
    init(){}
    
    func login(){
        guard validate() else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: password)
        
    }
    
    func validate()->Bool{
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            errorMessage = "Lütfen tüm alanları doldurunuz!"
            return false
        }
        guard email.contains("@") && email.contains(".") else{
            errorMessage = "Geçerli bir email adresi giriniz!"
            return false
        }
        return true
    }
}
