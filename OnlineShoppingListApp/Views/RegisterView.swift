//
//  RegisterView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel=RegisterViewViewModel()
    @State private var isPasswordVisible=false
    
    var body: some View {
        NavigationStack{
            VStack{
                HeaderView()
                    .padding(.bottom,10)
                Divider()
                Spacer()
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                    }
                    Section(header: Text("Kayıt Formu")){
                        TextField("Tam adınız",text: $viewModel.name)
                            .autocorrectionDisabled()
                        TextField("Email adresiniz", text: $viewModel.email)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        HStack {
                            if isPasswordVisible {
                                TextField("Şifreniz", text: $viewModel.password)
                            } else {
                                SecureField("Şifreniz", text: $viewModel.password)
                            }
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }.frame(height: 200)
                
                BigButton(title: "Kayıt Ol", action: {viewModel.register()})
                Spacer()
                VStack{
                    Text("Zaten bizden biri misin?")
                    NavigationLink("Giriş yap!",destination: LoginView())
                    
                }.padding(.bottom,200)
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

#Preview {
    RegisterView()
}
