
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
        configureUI()
        
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
            
        }}
    func configureUI(){
        self.view.backgroundColor = UIColor.white
        //グラデーション処理
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.orange.cgColor,UIColor.yellow.cgColor]
        gradientLayer.locations = [0,0.9]
        gradientLayer.frame = self.view.bounds
        //グラデーションの開始地点・終了地点の設定
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
    }
}

