//
//  MainView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    var followingId: String = "thereIsNoFollowingUser"
//    init() {
//        self._viewModel = StateObject(wrappedValue: MainViewViewModel())
//        self.viewModel.getFollowingUserId{followingUserId in
//            if let id = followingUserId{
//                self.followingId=id
//            }
//        }
//    }
    init(){
        MainViewViewModel()
    }
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
            accountView
            
        }else{
            LoginView()
        }
        
    }
    @ViewBuilder
    var accountView: some View{
        TabView{
            TakenListView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("Alınacaklar",systemImage: "cart")
                }
            CommonUserTakenListView(userId: viewModel.currentUserId, followingUserId: viewModel.followingUserId,username: viewModel.username)
                .tabItem{
                    Label("Ortak Liste",systemImage: "cart.badge.plus")
                }
            SearchView()
                .tabItem{
                    Label("Arama",systemImage:"magnifyingglass")
                }
            CurrentUserProfileView()
                .tabItem {
                    Label("Profil",systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    MainView()
}
