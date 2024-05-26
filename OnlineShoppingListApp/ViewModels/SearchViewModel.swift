//
//  SearchViewModel.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 14.05.2024.
//

import Foundation
class SearchViewModel: ObservableObject{
    @Published var users = [User]()
    @Published var isLoading = false
    @Published var value: String = ""
    init(){
        Task{try await fetchAllUsers()}
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.fetchAllUsers()
    }
    
    
    
}
