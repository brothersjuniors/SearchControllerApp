
//  DetailViewController.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/03/30.
//

import UIKit
import RealmSwift
class DetailViewController: UIViewController {
   // var item: Products!
    static var box = Int()
    let realm = try! Realm()
    private var searchedItem = [Products]()
    var data: Results<Products>!
public var item: Products?
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capaLabel: UILabel!
    @IBOutlet weak var janLabel: UILabel!
    @IBOutlet weak var janImage: UIImageView!
    var janString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
      
            
         makerLabel.text = item?.maker
        janString = item?.janID
        //makerLabel.text = item?.maker
        nameLabel.text = item?.name
        capaLabel.text = item?.capa
        janLabel.text = item?.janID
        data = realm.objects(Products.self)
        DispatchQueue.main.async { [self] in
            
            let image =  BarcodeGenerator.generateBarCode(from: "\(janString ?? "4902011713725")")!
            janImage.image = image
          
        }
    }
    
    
}


