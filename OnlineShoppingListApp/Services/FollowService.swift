//
//  FollowService.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 18.05.2024.
//

import Foundation
import Firebase

class FollowService : ObservableObject{
    
    // Firestore referansını alın
    static let db = Firestore.firestore()
    
    // Kullanıcının takip durumunu kontrol et
    static func checkFollowingStatus(userId: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(false) // Kullanıcı oturumu açmamışsa false döndür
            return
        }
        
        // Firestore sorgusu ile kullanıcının takip edip etmediğini kontrol et
        db.collection("users").document(currentUserID).collection("following").document(userId).getDocument { snapshot, error in
            if let error = error {
                print("Error getting following status: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let _ = snapshot?.data() {
                completion(true) // Kullanıcı takip ediliyorsa true döndür
            } else {
                completion(false) // Kullanıcı takip edilmiyorsa false döndür
            }
        }
    }
    
    static func followUser(userId: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(false) // Kullanıcı oturumu açmamışsa false döndür
            return
        }
        
        // Firestore'da kullanıcının takip edildiğini kaydedin
        db.collection("users").document(currentUserID).collection("following").document(userId).setData(["timestamp": Date()]) { error in
            if let error = error {
                print("Error following user: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Takip işlemi başarıyla tamamlandı, followersCount ve followingCount'i güncelle
            incrementFollowersCount(for: userId)
            incrementFollowingCount(for: currentUserID)
            
            // Takip edilen kullanıcının followers dizisine takip eden kullanıcının user id'sini ekle
            db.collection("users").document(userId).updateData([
                "followers": FieldValue.arrayUnion([currentUserID])
            ]) { error in
                if let error = error {
                    print("Error updating followers list: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
            
            // Takip eden kullanıcının following dizisine takip edilen kullanıcının user id'sini ekle
            db.collection("users").document(currentUserID).updateData([
                "following": FieldValue.arrayUnion([userId])
            ]) { error in
                if let error = error {
                    print("Error updating following list: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }

    
    static func unfollowUser(userId: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(false) // Kullanıcı oturumu açmamışsa false döndür
            return
        }
        
        // Firestore'da kullanıcının takibinin bırakıldığını kaydedin
        db.collection("users").document(currentUserID).collection("following").document(userId).delete { error in
            if let error = error {
                print("Error unfollowing user: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Takip bırakma işlemi başarıyla tamamlandı, followersCount ve followingCount'i güncelle
            decrementFollowersCount(for: userId)
            decrementFollowingCount(for: currentUserID)
            
            // Takip edilen kullanıcının followers dizisinden takip eden kullanıcının user id'sini sil
            db.collection("users").document(userId).updateData([
                "followers": FieldValue.arrayRemove([currentUserID])
            ]) { error in
                if let error = error {
                    print("Error removing follower from list: \(error.localizedDescription)")
                    completion(false)
                    return
                }
            }
            
            // Takip eden kullanıcının following dizisinden takip edilen kullanıcının user id'sini sil
            db.collection("users").document(currentUserID).updateData([
                "following": FieldValue.arrayRemove([userId])
            ]) { error in
                if let error = error {
                    print("Error removing following from list: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }

    
    // Takipçi sayısını artır
    static func incrementFollowersCount(for userId: String) {
        let userRef = db.collection("users").document(userId)
        userRef.updateData(["followersCount": FieldValue.increment(Int64(1))])
    }
    
    // Takip edilen sayısını artır
    static func incrementFollowingCount(for userId: String) {
        let userRef = db.collection("users").document(userId)
        userRef.updateData(["followingCount": FieldValue.increment(Int64(1))])
    }
    
    // Takipçi sayısını azalt
    static func decrementFollowersCount(for userId: String) {
        let userRef = db.collection("users").document(userId)
        userRef.updateData(["followersCount": FieldValue.increment(Int64(-1))])
    }
    
    // Takip edilen sayısını azalt
    static func decrementFollowingCount(for userId: String) {
        let userRef = db.collection("users").document(userId)
        userRef.updateData(["followingCount": FieldValue.increment(Int64(-1))])
    }
}

