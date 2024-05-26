//
//  User.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//

import Foundation
import Firebase

struct User: Codable, Identifiable, Hashable{
    let id: String
    var name: String
    var searchname: [String]?
    var profileImageUrl: String? 
    let email: String
    let joined: TimeInterval
    var followersCount: Int?
    var followingCount: Int?
    var followers: [String]?
    var following: [String]?
    
    var isCurrentUser: Bool{
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
}

extension User{
    static var MOCK_USER: [User] = [
        .init(id: UUID().uuidString, name: "monkey1", profileImageUrl: "gs://onlineshoppinglistapp.appspot.com/profile_Image/25BD35BF-AD54-4F6D-AB13-20F39FC3E182", email: "monkey1@monkey1.com", joined: 2003-01-01,followersCount: 105,followingCount: 210),
        .init(id: UUID().uuidString, name: "monkey2", profileImageUrl: "", email: "monkey2@monkey2.com", joined: 2003-01-01),
        .init(id: UUID().uuidString, name: "monkey3", profileImageUrl: "", email: "monkey3@monkey3.com", joined: 2003-01-01),
        .init(id: UUID().uuidString, name: "monkey4", profileImageUrl: "", email: "monkey4@monkey4.com", joined: 2003-01-01),
        .init(id: UUID().uuidString, name: "monkey5", profileImageUrl: "logo", email: "monkey5@monkey5.com", joined: 2003-01-01)
    ]
}
