//
//  EditUserInfoViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/09/25.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB

class EditUserInfoViewController: UIViewController ,UITextFieldDelegate ,UITextViewDelegate{
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var introducdeTextView: UITextView!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        userIdTextField.delegate = self
        introducdeTextView.delegate = self
        
        let userId = NCMBUser.current().userName
        userIdTextField.text = userId
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    @IBAction func closeEditViewController() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
