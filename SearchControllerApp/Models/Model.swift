//
//  Model.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/03/25.
//
//
//  Model.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/03/25.
//

import Foundation
import RealmSwift

class Products: Object {
    @objc dynamic var maker = ""
    @objc dynamic var name = ""
    @objc dynamic var capa = ""
    @objc dynamic var janID = ""
    @objc dynamic var id = ""
  //  @objc dynamic  var date = Date()
   
}
class ItemList: Object{
    let list = List<Products>()
}

//class ProducsItem {
//    var maccccccckerName: String
//    var capacity: String
//    var jan: String
//    var productName: String
//    init(makerName: String, capacity: String, jan: String, productName: String) {
//        self.makerName = makerName
//        self.capacity = capacity
//        self.jan = jan
//        self.productName = productName
//    }
//}
