//
//  TrainningViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB

class TrainningViewController: UIViewController ,UITableViewDataSource{
    
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var countTextField: UITextField!
    @IBOutlet var setTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var TrainningTableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバーのタイトルのフォントと色変更
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Cochin", size: 20)!]
        
        TrainningTableView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func selectMenu() {
        
        
        
    
    }
    
    
    @IBAction func saveMenu() {
        // クラスのNCMBObjectを作成
        let saveObj = NCMBObject(className: "Trainning")
        // オブジェクトに値を設定
        /** 文字列 **/
        saveObj?.setObject(self.dateTextField.text, forKey: "date")
        saveObj?.setObject(self.menuButton.currentTitle, forKey: "menu")
        saveObj?.setObject(self.countTextField.text, forKey: "count")
        saveObj?.setObject(self.setTextField.text, forKey: "set")
        saveObj?.setObject(self.weightTextField.text, forKey: "weight")

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
        
    }
    
    @IBAction func cancel() {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainningCell")!
        cell.textLabel?.text = "a"
        
        return cell
        
        
    }
    
    
    
    
    
    
    
}
