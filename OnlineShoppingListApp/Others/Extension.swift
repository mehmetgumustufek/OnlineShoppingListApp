//
//  Extension.swift
//  OnlineShoppingListApp
//
//  Created by Mehmet Gümüştüfek on 17.04.2024.
//

import Foundation
import SwiftUI
extension Encodable{
    func asDictionary( ) -> [String:Any]{
        guard let data = try? JSONEncoder().encode(self) else{
            return [:]
        }
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            return json ?? [:]
        }catch{
            return [:]
        }
    }
}

extension Decodable{
    init(fromDictionary: Any) throws{
        let data = try JSONSerialization.data(withJSONObject: fromDictionary, options: .prettyPrinted)
        
        let decoder = JSONDecoder()
        
        self = try decoder.decode(Self.self, from: data)
    }
}


extension String{
    func splitString( )->[String]{
        var stringArray: [String] = []
        let trimmed = String(self.filter{!"\n\t\r".contains($0)})
        for(index, _)in trimmed.enumerated(){
            let prefixIndex = index+1
            let substringPrefix = String(trimmed.prefix(prefixIndex)).lowercased()
            stringArray.append(substringPrefix)
        }
        return stringArray
    }
    
    func removeWhiteSpace() -> String{
        return components(separatedBy: .whitespaces).joined()
    }
}
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
