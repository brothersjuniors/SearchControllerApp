//
//  AddViewController.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/03/28.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    var str = ""
    var box = DataShowView.str
    var data: Results<Products>!
    let realm = try! Realm()
    @IBOutlet weak var buttonHandle: UIButton!
    @IBOutlet weak var makerTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var capaTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.keyboardType = .numberPad
        if DataShowView.str.count > 13 {
            idTextField.text = ""
        } else if DataShowView.str.count == 13 {
            idTextField.text = DataShowView.str
        } else if DataShowView.str.count == 8 {
            idTextField.text = DataShowView.str
        } else if idTextField.text == "" {
            buttonHandle.isEnabled = false
        }
        idTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    @objc func textFieldDidChange(sender: UITextField) {
        if idTextField.text!.count > 13 {
            buttonHandle.isEnabled = false
        } else if idTextField.text!.count == 13 {
            buttonHandle.isEnabled = true
        } else if idTextField.text!.count == 8 {
            buttonHandle.isEnabled = true
        } else if  idTextField.text!.count < 8  {
            buttonHandle.isEnabled = false
        } else if  idTextField.text!.count == 9 {
            buttonHandle.isEnabled = false
        } else if  idTextField.text!.count == 10 {
            buttonHandle.isEnabled = false
        } else if  idTextField.text!.count == 11 {
            buttonHandle.isEnabled = false
        } else if  idTextField.text!.count == 12 {
            buttonHandle.isEnabled = false
        }
    }
    @IBAction func saveButton(_ sender: Any) {
        guard let saveMaker = makerTextField.text else { return }
        guard let saveName = nameTextField.text else { return }
        guard let saveCapa = capaTextField.text else { return }
        guard let saveJan = idTextField.text else { return }
        _ = idTextField.text!
        Helper().saveDate(maker: saveMaker, name: saveName, capa: saveCapa, janId: saveJan, id: UUID().uuidString)
        makerTextField.text = ""
        nameTextField.text = ""
        capaTextField.text = ""
        DataShowView.str = ""
        idTextField.text = ""
        let tab = storyboard!.instantiateViewController(withIdentifier: "Main") as! ViewController
        self.navigationController?.pushViewController(tab, animated: true)
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "tab") as! UITabBarController
        navigationController.modalPresentationStyle = .fullScreen
        // 遷移先のNavigationControllerを設定
        self.present(navigationController, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
