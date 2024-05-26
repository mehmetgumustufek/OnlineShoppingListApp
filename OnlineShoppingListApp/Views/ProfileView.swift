//
//  ProfileView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
import SwiftUI
struct ProfileView: View {
    
    let user: User
    
    @State private var showEditProfile = false
    @State private var isFollowing = false
    
    
    private let gridItems: [GridItem]=[
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        
            ScrollView{
                VStack{
                    VStack(spacing:10){
                        
                        HStack{
                            AsyncImage(url: URL(string: user.profileImageUrl ?? "")) { phase in
                                switch phase {
                                case .empty:
                                Image(systemName: "person.circle")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                    
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                case .failure:
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                @unknown default:
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                }
                            }
                            Spacer()
                            HStack(spacing: 8){
                                UserStatView(value: user.followingCount ?? 0, title: "Takip Edilen")
                                UserStatView(value: user.followersCount ?? 0, title: "Takipçi")
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.name)
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal)
                        
                        Button(action: {
                                    if isFollowing {
                                        self.isFollowing = false
                                        FollowService.unfollowUser(userId: user.id) { success in
                                            if !success {
                                                self.isFollowing = true
                                            }
                                        }
                                    } else {
                                        self.isFollowing = true
                                        FollowService.followUser(userId: user.id) { success in
                                            if !success {
                                                self.isFollowing = false
                                            }
                                        }
                                    }
                                }) {
                                    Text(isFollowing ? "Takipten Çık" : "Takip Et")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .frame(width: 360,height: 32)
                                        .background(isFollowing ? Color.white : Color.blue)
                                        .foregroundColor(isFollowing ? .black : .white)
                                        .cornerRadius(6)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(isFollowing ? .gray : .clear, lineWidth: 1)
                                        )
                                }
                                .onAppear {
                                    FollowService.checkFollowingStatus(userId: user.id) { status in
                                        self.isFollowing = status
                                    }
                                }
                        Divider()
                    }
                }
            }
        }
}



#Preview {
    ProfileView(user: User.MOCK_USER[0])
}

