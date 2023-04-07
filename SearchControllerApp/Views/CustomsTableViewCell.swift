//
//  CustomsTableViewCell.swift
//  SearchControllerApp
//
//  Created by 近江伸一 on 2023/03/26.
//
import UIKit
import RealmSwift

class CustomsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var jan: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


