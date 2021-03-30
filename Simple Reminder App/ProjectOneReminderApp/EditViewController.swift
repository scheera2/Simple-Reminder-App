//
//  EditViewController.swift
//  ProjectOneReminderApp
//
//  Created by Aidan Scheer on 3/29/21.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    public var complete: ((String, String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        descriptionField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
           let descriptionText = descriptionField.text, !titleText.isEmpty {
            
            let targetDate = datePicker.date
            
            complete?(titleText, descriptionText, targetDate)
           }
          
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

