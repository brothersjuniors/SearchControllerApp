//
//  Helper.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/04/07.
//

import Foundation
import RealmSwift

class Helper{
    let realm = try! Realm()
    func saveDate(maker: String,name: String,capa: String,janId: String,id: String) {
        let newItem = Products()
        newItem.maker = maker
        newItem.name = name
        newItem.capa = capa
        newItem.janID = janId
        newItem.id = UUID().uuidString

        try! realm.write{
            realm.add(newItem)
        }
    }
    
    func deleteItem(item:Products){
        try! realm.write(){
            realm.delete(item)
        }
        
    }
}
