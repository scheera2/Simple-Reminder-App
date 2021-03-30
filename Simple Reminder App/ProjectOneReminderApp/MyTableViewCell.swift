//
//  cell.swift
//  ProjectOneReminderApp
//
//  Created by Aidan Scheer on 3/29/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let identifier = "MyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button: UIButton!
    
    @IBAction func didTapButton() {
        
    }
    
    func configure(with title:String) {
        button.setTitle(title, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        button.setTitleColor(.link, for: .normal)
    }
    
}

