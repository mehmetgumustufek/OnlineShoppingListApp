//
//  CommonUserTakenListItemView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 24.05.2024.
//

import SwiftUI

struct CommonUserTakenListItemView: View {
    @StateObject var viewModel=CommonUserTakenListItemViewViewModel()
    var item: TakenListItem
    let followingUserId: String
    var username: String

    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.title)
                    .font(.title)
                if item.isDone==true{
                    Text("Ürün \(username) tarafından alındı.")
                    
                }
            }
            Spacer()
            Button{
                viewModel.toggleIsDone(item: item,followingUserId: followingUserId, username: username)
                
            }
        label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(Color.blue)
            }
            
        }
    }
}

#Preview {
    CommonUserTakenListItemView(item: .init(id: "deneme", title: "denemetitle", isDone: false),followingUserId: "ybR4f0AI2PVotListMX0rSSPnRq1",username: "deneme username")
}

//DİĞER KULLANICININ ADININ GÖZÜKMESİ İÇİN LİSTELERDE İŞLEM YAP
