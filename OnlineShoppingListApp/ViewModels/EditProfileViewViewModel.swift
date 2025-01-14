//
//  EditProfileViewViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 14.05.2024.
//

import Foundation
import PhotosUI
import Firebase
import SwiftUI

@MainActor
class EditProfileViewViewModel: ObservableObject{
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem?{
        didSet {Task{ await loadImage(fromItem: selectedImage) }}
    }
    @Published var profileImage: Image?
    
    @Published var fullname = ""
    
    private var uiImage: UIImage?
    
    init(user: User){
        self.user = user
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async{
        guard let item = item else{return}
        
        guard let data = try? await item.loadTransferable(type: Data.self) else{return}
        
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData( ) async throws{
        var data = [String: Any]()
        
        if let uiImage = uiImage{
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
            
        }
        if !fullname.isEmpty && user.name != fullname{
            data["name"] = fullname
        }
        
        if !data.isEmpty{
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}
