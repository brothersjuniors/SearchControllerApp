//
//  DataShowView.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/04/07.
//


import UIKit
import RealmSwift
class DataShowView: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var dataBox = [String].self
    static var str = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationItem.title = "スキャンデータ"
        textView.text = DataShowView.str
        // スクリーンの横縦幅
        let screenWidth:CGFloat = self.view.frame.width
        let screenHeight:CGFloat = self.view.frame.height
        // ボタンのインスタンス生成
        let button = UIButton()
        // ボタンの位置とサイズを設定
        button.frame = CGRect(x:screenWidth * 4/5, y:screenHeight * 4/5,
                              width:60, height:60)
        button.layer.cornerRadius = 30
        // ボタンのタイトルを設定
        button.setTitle("+", for:UIControl.State.normal)
        // タイトルの色
        button.setTitleColor(UIColor.white, for: .normal)
        // ボタンのフォントサイズ
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 36)
        // 背景色
        button.backgroundColor = UIColor.blue
        // action
        button.addTarget(self,
                         action: #selector(addItem),
                         for: .touchUpInside)
        // Viewにボタンを追加
        self.view.addSubview(button)
    }
    
    @objc func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "検出したデータ", message: "このデータを使用しますか？", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { [self] (action) in
            let nextView = storyboard!.instantiateViewController(withIdentifier: "addViewController") as! AddViewController//遷移先のViewControllerを設定
            
            //遷移する
            
            self.navigationController?.pushViewController(nextView, animated: true)
            let navigationController = storyboard!.instantiateViewController(withIdentifier: "navigation") as! UINavigationController
            
            
            //遷移先のNavigationControllerを設定
            self.present(navigationController, animated: true, completion: nil)
            
            
        }
        //ここから追加
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
        
            DataShowView.str = ""
            let tab = self.storyboard!.instantiateViewController(withIdentifier: "Main") as! ViewController
            self.navigationController?.pushViewController(tab, animated: true)
            let navigationController = self.storyboard!.instantiateViewController(withIdentifier: "tab") as! UITabBarController
            
            navigationController.modalPresentationStyle = .fullScreen
            // 遷移先のNavigationControllerを設定
            self.present(navigationController, animated: true, completion: nil)
            // self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        //ここまで追加
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    // segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueのIDを確認して特定のsegueのときのみ動作させる
        if segue.identifier == "addViewController" {
            // 2. 遷移先のViewControllerを取得
            let next = segue.destination as? AddViewController
            // 3. １で用意した遷移先の変数に値を渡す
            next?.idTextField.text = DataShowView.str
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func configureUI(){
        self.view.backgroundColor = UIColor.white
        //グラデーション処理
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPink.cgColor,UIColor.systemBlue.cgColor]
        gradientLayer.locations = [0,0.9]
        gradientLayer.frame = self.view.bounds
        //グラデーションの開始地点・終了地点の設定
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
    }
}
