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
    var str = ""
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = str
        //ここに記載
        self.button.layer.cornerRadius = 50
        self.button.frame = CGRect(x: (self.view.frame.size.width / 2) - 150, y: (self.view.frame.size.height / 2) - 50, width: 100, height: 100)
        self.button.backgroundColor = UIColor.red
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "検知しました", message: "新たにこのコードを追加しますか？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            
        })
        )
        self.present(alert, animated: true, completion: nil)
    }
}


