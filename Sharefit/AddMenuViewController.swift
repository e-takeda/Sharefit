//
//  AddMenuViewController.swift
//  Sharefit
//
//  Created by 武田　瑛璃 on 2017/10/11.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB

class AddMenuViewController: UIViewController {
    
    @IBOutlet var menuTextField: UITextField!
    @IBOutlet var detailTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        let saveObj = NCMBObject(className: "Menu")
        // オブジェクトに値を設定
        /** 文字列 **/
        saveObj?.setObject(self.menuTextField.text, forKey: "menu")
        saveObj?.setObject(self.detailTextView.text, forKey: "detail")
        
        // データストアへの保存を実施
        saveObj?.saveInBackground({ (error) in
            if error != nil {
                // 保存に失敗した場合の処理
                print("error")
            }else{
                // 保存に成功した場合の処理
                print("success")
            }
        })
        
        self.dismiss(animated: true, completion: nil)
    }

    

}
