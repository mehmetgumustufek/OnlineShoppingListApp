//
//  UserStatView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 12.05.2024.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    var body: some View {
        VStack{
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("\(title)")
                .font(.subheadline)
        }
        .frame(width: 140)
    }
}

#Preview {
    UserStatView(value: 10,title: "takip edilen")
}
