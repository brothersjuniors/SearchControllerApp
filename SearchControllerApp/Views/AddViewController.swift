//
//  AddViewController.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/03/28.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    var data: Results<Products>!
    let realm = try! Realm()
    @IBOutlet weak var makerTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var capaTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(Products.self).sorted(byKeyPath: "maker",ascending: true)
        idTextField.keyboardType = .numberPad
    }
    @IBAction func saveButton(_ sender: Any) {
        guard let saveMaker = makerTextField.text else { return }
        guard let saveName = nameTextField.text else { return }
        guard let saveCapa = capaTextField.text else { return }
        guard let saveJan = idTextField.text else { return }
        _ = idTextField.text!
//        if id.count < 12 || id.count > 13 {
//            guard let saveJan = idTextField.text else { return }
//        }
        Helper().saveDate(maker: saveMaker, name: saveName, capa: saveCapa, janId: saveJan, id: UUID().uuidString)
        makerTextField.text = ""
        nameTextField.text = ""
        capaTextField.text = ""
        idTextField.text = ""
    }
}
