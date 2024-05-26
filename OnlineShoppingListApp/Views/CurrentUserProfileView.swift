//
//  CurrentUserProfileView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 12.05.2024.
//
import FirebaseFirestoreSwift
import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel=ProfileViewViewModel()
    
    @State private var showEditProfile = false
   
    init() {}
    var body: some View {
        NavigationView{
            
            VStack{
                if let user = viewModel.user {
                    profile(user: user, profileImageUrl: viewModel.user?.profileImageUrl)
                    BigButton(title: "Profili Düzenle"){
                        showEditProfile.toggle()
                    }
                } else{
                    Text("Profil yükleniyor...")
                }
                BigButton(title: "Hesabı Sil"){
                    viewModel.deleteProfile()
                }
                BigButton(title: "Çıkış Yap"){
                    viewModel.logout()
                }
                
                
            }.fullScreenCover(isPresented: $showEditProfile) {
                if let user = viewModel.user {
                    EditProfileView(user: user)
                }
            }       
            .navigationTitle("Profil")
            
        }
        .onAppear{
            viewModel.fetchUser()
        }
    }
}
@ViewBuilder
func profile(user: User, profileImageUrl: String?) -> some View{
    HStack(spacing: 8) {
        
        if let urlString = user.profileImageUrl,!urlString.isEmpty, let url = URL(string: urlString){
            AsyncImage(url: url) {
                phase in
                switch phase {
                case .empty:
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading,10)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading,10)
          
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading,10)
                @unknown default:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.leading,10)
                }
            }
        }else{
            Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .padding(.leading,10)
        }
        UserStatView(value: user.followingCount ?? 0, title: "Takip edilenler")
        UserStatView(value: user.followersCount ?? 0, title: "Takipçiler")
    }
    VStack(alignment: .leading, spacing: 4){
        HStack{
            Text("İsim:")
            Text(user.name)
        }
        HStack{
            Text("Email:")
            Text(user.email)
        }
        HStack{
            Text("Kayıt Tarihi:")
            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated,time: .shortened))")
        }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal)
    Spacer()
}

#Preview {
    CurrentUserProfileView()
}
