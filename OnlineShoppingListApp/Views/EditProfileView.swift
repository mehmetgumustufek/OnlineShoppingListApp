//
//  EditProfileView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 14.05.2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    
    @StateObject var viewModel: EditProfileViewViewModel
    init (user: User){
        self._viewModel = StateObject(wrappedValue: EditProfileViewViewModel(user: user))
    }
    var body: some View {
        VStack{
            VStack {
                HStack{
                    Button("Cancel"){
                        dismiss()
                    }
                    Spacer()
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    Button("Done"){
                        Task{
                            do{
                                try await viewModel.updateUserData()
                                dismiss()
                            } catch{
                                print(error.localizedDescription)
                            }
                            
                        }
                        
                    }
                    .font(.subheadline)
                    .fontWeight(.bold)
                }
                .padding()
                Divider()
            }
            PhotosPicker(selection: $viewModel.selectedImage){
                VStack{
                    if let image = viewModel.profileImage{
                        image
                            .resizable()
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 100,height: 100)
                    }else{
                        Image(systemName: "person")
                            .resizable()
                            .foregroundStyle(.white)
                            .background(.gray)
                            .clipShape(Circle())
                            .frame(width: 100,height: 100)
                    }
                    Text("Edit Profile Picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Divider()
                        
                }
            }
            .padding(.vertical,8)
            
            
            VStack{
                EditProfileRowView(title: "Name", placeholder: "Enter your name...", text: $viewModel.fullname)
            }
            Spacer()
        }
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USER[0])
}
