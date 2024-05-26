//
//  SearchView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 12.05.2024.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var value: String = ""
    @State var isLoading = false
    @State var users: [User] = []
    
    @StateObject var viewModel = SearchViewModel()
    
    func searchUsers( ){
        isLoading=true
        SearchService.searchUser(input: value){
            (users) in
            self.isLoading = false
            self.users=users
        }
    }
    //burada lazy v stack içine alarak search barın görünümünü düzelt
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading){
                    SearchBarView(value: $value)
                        .padding()
                        .onChange(of: value, perform: {
                            new in
                            searchUsers()
                        })
                    if !isLoading{
                        ForEach(users, id:\.id){
                            user in
                            NavigationLink(value: user) {
                                HStack{
                                    AsyncImage(url: URL(string: user.profileImageUrl ?? "")){
                                        phase in
                                        switch phase {
                                        case .empty:
                                            Image(systemName: "person.circle")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                            
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                        case .failure:
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                        @unknown default:
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 40, height: 40)
                                                .clipShape(Circle())
                                        }
                                        
                                        
                                    }
                                    VStack(alignment: .leading){
                                        Text("\(user.name)")
                                            .fontWeight(.bold)
                                        Text("\(user.email)")
                                    }
                                    
                                }
                                .alignmentGuide(.leading, computeValue: { _ in -40})
                            }
                        }
                    }
                    
                }
            }
            .navigationDestination(for: User.self, destination:
                                    {user in ProfileView(user: user)}
            )
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
    }
}
//        NavigationStack {
//            ScrollView{
//                LazyVStack{
//                    ForEach(viewModel.users){user in
//                        NavigationLink(value: user) {
//                            HStack{
//                                AsyncImage(url: URL(string: user.profileImageUrl ?? "")) { phase in
//                                    switch phase {
//                                    case .empty:
//                                    Image(systemName: "person.circle")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 40, height: 40)
//                                            .clipShape(Circle())
//                                       
//                                    case .success(let image):
//                                        image
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 40, height: 40)
//                                            .clipShape(Circle())
//                                    case .failure:
//                                        Image(systemName: "person.crop.circle.fill")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 40, height: 40)
//                                            .clipShape(Circle())
//                                    @unknown default:
//                                        Image(systemName: "person.crop.circle.fill")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(width: 40, height: 40)
//                                            .clipShape(Circle())
//                                    }
//                                }
////                                var userImageUrl = user.profileImageUrl
////                                Image(userImageUrl)
////                                    .resizable()
////                                    .scaledToFill()
////                                    .frame(width: 40,height: 40)
////                                    .clipShape(Circle())
//                                //kullanıcı adı ve email görüntüsü
//                                VStack(alignment: .leading){
//                                    Text(user.name)
//                                        .fontWeight(.semibold)
//                                        
//                                    Text(user.email)
//                                }.font(.footnote)
//                                Spacer()
//                            }
//                            .padding(.horizontal)
//                        }
//                        
//                    }
//                }
//                .searchable(text: $searchText, prompt: "Ara...")
//            }
//            .navigationDestination(for: User.self, destination: {user in
//                ProfileView(user: user)
//            }
//            )
//            .navigationTitle("Arkadaş Ekle")
//            .navigationBarTitleDisplayMode(.inline)
//            
//        }
//    }


#Preview {
    SearchView()
}
