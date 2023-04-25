//
//  CommitView.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/03/26.
//

import UIKit
import RealmSwift
class CommitView: UIViewController{
    static var box = Int()
    let realm = try! Realm()
    var data: Results<Products>!
    @IBOutlet weak var makerTextField: UITextField!
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var capaTextField: UITextField!
    @IBOutlet weak var janTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(Products.self).sorted(byKeyPath: "maker",ascending: true)
        makerTextField.text = data[CommitView.box].maker
        productTextField.text = data[CommitView.box].name
        capaTextField.text = data[CommitView.box].capa
        janTextField.text = data[CommitView.box].janID
        janTextField.keyboardType = .numberPad
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let saveMaker = makerTextField.text else { return }
        guard let saveName = productTextField.text else { return }
        guard let saveCapa = capaTextField.text else { return }
        guard let saveJan = janTextField.text else { return }
        Helper().saveDate(maker: saveMaker, name: saveName, capa: saveCapa, janId: saveJan, id: UUID().uuidString)
        makerTextField.text = ""
        productTextField.text = ""
        capaTextField.text = ""
        janTextField.text = ""
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // キーボードを閉じる
        view.endEditing(true)
    }
}
