//
//  HeaderView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack{
            Image("AppIcon1")
                .resizable()
                .frame(width: 150,height: 150)
            Text("Shopping App")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top,180)
        }.padding(.top,100)
    }
}

#Preview {
    HeaderView()
}
