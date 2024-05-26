//
//  CommonNewItemView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 24.05.2024.
//

import SwiftUI

struct CommonNewItemView: View {
    @Binding var newItemPresented: Bool
    @StateObject var viewModel=CommonNewItemViewViewModel()
    var followingUserId: String
    
    var body: some View {
        VStack{
            Text("Yeni Ürün")
                .font(.title)
                .bold()
                .padding(.top,100)
            Form{
                TextField("Listeye eklenecek ürün bilgisi",text: $viewModel.title)
                BigButton(title: "Kaydet"){
                    if viewModel.canSave{
                        viewModel.save(followingUserId: followingUserId)
                        newItemPresented=false
                    }else{
                        viewModel.showAlert=true
                    }
                    
                }
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text("Hata"),
                    message: Text("Lütfen tutarlı veriler giriniz!"))
                
            })
        }
    }
}

#Preview {
    CommonNewItemView(newItemPresented: Binding(get:{
        return true
    }, set: { _ in
    }) , followingUserId: "Xl03E2plC7cKW285Wf0KTGvWJV92"
    )
}
