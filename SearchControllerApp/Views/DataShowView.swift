//
//  DataShowView.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/04/07.
//


import UIKit

class DataShowView: UIViewController {
 @IBOutlet weak var textView: UITextView!
    var str = ""
      override func viewDidLoad() {
            super.viewDidLoad()
            textView.text = str
            
        }
    }
