//
//  CommonUserTakenListView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 21.05.2024.
//

import FirebaseFirestoreSwift
import FirebaseFirestore
import UserNotifications
import SwiftUI

struct CommonUserTakenListView: View {
    @StateObject var viewModel: CommonUserTakenListViewViewModel
    @FirestoreQuery var items: [TakenListItem]
    var followingUserId: String?
    @State private var listener: ListenerRegistration?
    var username: String
    
    init(userId: String, followingUserId: String, username: String) {
        self._viewModel = StateObject(wrappedValue: CommonUserTakenListViewViewModel(followingUserId: followingUserId))
        self.followingUserId = followingUserId
        self._items=FirestoreQuery(collectionPath: "users/\(followingUserId)/willBeTaken")
        self.username=username
    }
    var body: some View {
        NavigationView {
            VStack {
                if let followingUserId = followingUserId {
                    if followingUserId == "thereIsNoFollowingUser"{
                        VStack{
                            Text("Henüz takip edilen kullanıcı yok!")
                                .multilineTextAlignment(.center)
                            Text("Kullanıcı takip edilmesine rağmen liste güncellenmiyorsa lütfen uygulamaya tekrar giriş yapınız!")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                    }else{
                        List(items) { item in
                            CommonUserTakenListItemView(item: item, followingUserId: followingUserId,username: username)
                                .swipeActions {
                                    Button("Sil") {
                                        viewModel.delete(id: item.id)
                                    }.background(.red)
                                }
                        }
                        .listStyle(.plain)
                    }
                    
                }
            }
            
            .navigationTitle("Alınacaklar")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                CommonNewItemView(newItemPresented: $viewModel.showingNewItemView, followingUserId: followingUserId ?? "boşluk")
            }
            
        }
    }
    

}
