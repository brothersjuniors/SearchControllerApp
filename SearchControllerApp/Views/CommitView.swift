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
   
    @IBOutlet weak var reRegisterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        congigure2()
        data = realm.objects(Products.self).sorted(byKeyPath: "maker",ascending: true)
        makerTextField.text = data[CommitView.box].maker
        productTextField.text = data[CommitView.box].name
        capaTextField.text = data[CommitView.box].capa
        janTextField.text = data[CommitView.box].janID
        janTextField.keyboardType = .numberPad
        janTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
    func congigure2(){
        makerTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        productTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        capaTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
        janTextField.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    @objc func textFieldDidChange(sender: UITextField) {
        calculateEAN13CheckDigit(barcode: janTextField.text!)
        if janTextField.text!.count > 13 {
            reRegisterButton.isEnabled = false
        } else if janTextField.text!.count < 13 {
            reRegisterButton.isEnabled = false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // キーボードを閉じる
        view.endEditing(true)
    }
    func configureUI(){
        self.view.backgroundColor = UIColor.white
        //グラデーション処理
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.lightGray.cgColor,UIColor.white.cgColor]
        gradientLayer.locations = [0,0.9]
        gradientLayer.frame = self.view.bounds
        //グラデーションの開始地点・終了地点の設定
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
    }
    private func calculateEAN13CheckDigit(barcode: String) -> Int {
        // 13桁のバーコードを取得する
        let digits = barcode.compactMap { Int(String($0)) }
        print(digits)
        // 奇数の数字を掛け合わせる
        let oddDigits = digits.enumerated().filter { $0.offset % 2 == 1 }.map { $0.element * 3 }
        print(oddDigits)
        // 偶数の数字を足し合わせる
        let evenDigits = digits.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }
        print(evenDigits)
        // 奇数の数字の合計と偶数の数字の合計を足す
        let sum = oddDigits.reduce(0, +) + evenDigits.reduce(0, +)
        
        if sum % 10 == 0 {
            reRegisterButton.isEnabled = true
            print(sum % 10)
        }else {
            reRegisterButton.isEnabled = false
            print(sum % 10)
        }
        // 合計の1の位を返す
        return sum % 10
    }
    //８桁JANコード用
//    func getCheckDigit(forCode code: String) -> String {
//        var answer = ""
//        var threeODigits = [0]
//        var digits = code.compactMap { Int(String($0)) }
//        print(digits)
//        // 奇数の数字を掛け合わせる
//        let oddDigits = digits.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element * 3 }
//        print(oddDigits)
//        // ぐう数の数字を足し合わせる
//        let evenDigits = digits.enumerated().filter { $0.offset % 2 == 1 }.prefix(3).map { $0.element }
//        print(evenDigits)
//        // 奇数の数字の合計と偶数の数字の合計を足す
//        let number = oddDigits.reduce(0, +) + evenDigits.reduce(0, +)
//        getDigit(number)
//        answer = String(10-getDigit(number))
//        let lastDigits = digits.last
//        if Int(answer) == lastDigits {
//            eightDigit.isEnabled = true }
//        else {
//            eightDigit.isEnabled = false
//        }
//        return answer
//    }
//    func getDigit(_ number: Int) -> Int {
//        let totalsum = number % 10
//        return totalsum
//        
//        
//        
//    }
    
}
