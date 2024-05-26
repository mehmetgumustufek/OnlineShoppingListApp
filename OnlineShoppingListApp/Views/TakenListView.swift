//
//  TakenListView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//
import FirebaseFirestoreSwift
import FirebaseFirestore
import UserNotifications
import SwiftUI

struct TakenListView: View {
    @StateObject var viewModel: TakenListViewViewModel
    @FirestoreQuery var items: [TakenListItem]
    var userId: String
    @State private var listener: ListenerRegistration?
    
    init(userId: String){
        self._items=FirestoreQuery(collectionPath: "users/\(userId)/willBeTaken")
        self._viewModel = StateObject(wrappedValue: TakenListViewViewModel(userId: userId))
        self.userId=userId
    }
    var body: some View {
        NavigationView{
            VStack{
                List(items){ item in
                    TakenListItemView(item: item)
                        .swipeActions{
                            Button("Sil"){
                                viewModel.delete(id: item.id)
                            }.background(.red)
                        }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Alınacaklar")
            .toolbar{
                Button{
                    viewModel.showingNewItemView=true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView, content: {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            })
        }
    }
}

#Preview {
    TakenListView(userId: "bt7c1ulrsSYtczTcQdfqRXyJWLM2")
}
