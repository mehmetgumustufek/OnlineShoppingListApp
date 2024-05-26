//
//  ImageUploader.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 15.05.2024.
//

import Foundation
import Firebase
import FirebaseStorage
struct ImageUploader{
    
    static func uploadImage(image: UIImage) async throws -> String?{
        guard let imageData = image.jpegData(compressionQuality: 0.75) else{return nil}
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_Image/\(filename)")
        
        do{
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        }catch{
            print("Dosya yüklenirken hata oluştu \(error.localizedDescription)")
            return nil
        }
        
    }
}
