//
//  TakenListItemView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//

import SwiftUI

struct TakenListItemView: View {
    @StateObject var viewModel=TakenListItemViewViewModel()
    var item: TakenListItem
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.title)
                    .font(.title)
                if item.isDoneByWho?.isEmpty==false{
                    Text("Ürün \(item.isDoneByWho!) tarafından alınmıştır.")
                }
                //item isdonebywho doluysa text açılsın
            }
            Spacer()
            Button{
                viewModel.toggleIsDone(item: item)
                
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(Color.blue)
            }
        }
    }
}

#Preview {
    TakenListItemView(item: .init(id: "123", title: "yoğurt", isDone: false))
}
