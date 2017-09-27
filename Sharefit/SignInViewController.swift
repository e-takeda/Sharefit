//
//  SignInViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/09/06.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Cochin", size: 20)!]
        
        userIdTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func signIn(){
        
        if (userIdTextField.text?.characters.count)! > 0 && (passwordTextField.text?.characters.count)! > 0{
            
            NCMBUser.logInWithUsername(inBackground: userIdTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error != nil {
                    print(error)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    // ログイン情報の保持
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "isLogin")
                    ud.synchronize()
                }
                
            }
            
            
        }
        
        
        
    
        
        
    }
    
    @IBAction func forgetPass(){
        //　置いておく
        
    }
    

}
