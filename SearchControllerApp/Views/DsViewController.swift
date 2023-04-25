//
//  DsViewController.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/04/25.
//

import UIKit

class DsViewController: UIViewController {
    var filtered: Products!
    var maker: String = ""
    
    @IBOutlet weak var makerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makerLabel.text = filtered.maker
        
    }
    
    
    }
