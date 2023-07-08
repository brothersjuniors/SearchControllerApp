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
        configureUI()
        congigure2()
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
    func congigure2(){
        makerTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        capaTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
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
       
        //  (from: "\(janString ?? "4902011713725")")!
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
    func configureUI(){
        self.view.backgroundColor = UIColor.white
        //グラデーション処理
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPurple.cgColor,UIColor.systemBlue.cgColor]
        gradientLayer.locations = [0,0.9]
        gradientLayer.frame = self.view.bounds
        //グラデーションの開始地点・終了地点の設定
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
    }
}
