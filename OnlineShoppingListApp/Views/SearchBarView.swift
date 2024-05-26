//
//  SearchBarView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 17.05.2024.
//

import SwiftUI
    

struct SearchBarView: View {
    @Binding var value: String
    @State var isSearching = false
    
    
    var body: some View {
        HStack{
            TextField("Ara...", text: $value)
                .padding(.leading,24)
            if !value.isEmpty{
                Button(action: {value=""}){
                    Image(systemName: "delete.left.fill")
                }.foregroundStyle(.gray)
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(6.0)
        .padding(.horizontal)
        .onTapGesture(perform: {
            isSearching = true
        })
        .overlay(
            HStack{
                Image(systemName: "magnifyingglass")
                Spacer()
                
//                Button(action: {value = ""}){
//                    Image(systemName: "delete.left.fill")
//                }
                
            }
                .padding(.horizontal,32)
                .foregroundColor(.gray)
        )
        
    }
}

