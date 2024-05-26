//
//  LoginView.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 16.04.2024.
//

import SwiftUI

struct LoginView: View {

    @StateObject var viewModel=LoginViewViewModel()
    @State private var isPasswordVisible=false
    
    var body: some View {
        NavigationStack{
            VStack{
                HeaderView()
                Divider()
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                        
                    }
                    TextField("Email Adresiniz",text: $viewModel.email)
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
                .frame(height: 200)
                BigButton(title: "Giriş Yap", action: {viewModel.login()})
                Spacer()
                VStack{
                    Text("Buralarda yeni misin?")
                    NavigationLink("Yeni hesap oluştur!",destination: RegisterView())
                    
                }.padding(.bottom,150)
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

#Preview {
    LoginView()
}
