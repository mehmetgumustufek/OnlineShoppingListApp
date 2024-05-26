//
//  NewItemView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//

import SwiftUI

struct NewItemView: View {
    @Binding var newItemPresented: Bool
    @StateObject var viewModel=NewItemViewViewModel()
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
                        viewModel.save()
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
    NewItemView(newItemPresented: Binding(get:{
        return true
    }, set: { _ in
    })  )
}
