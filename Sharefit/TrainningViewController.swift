//
//  TrainningViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB

class TrainningViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var countTextField: UITextField!
    @IBOutlet var setTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var TrainningTableView: UITableView!
    
    var trainningArray = [String]()
    var daylytrainningArray = [String]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバーのタイトルのフォントと色変更
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Cochin", size: 20)!]
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        print(formatter.string(from: Date()))
        
        dateTextField.text = formatter.string(from: Date())
        menuButton.setTitle("menuを選択", for: .normal)

        
        TrainningTableView.dataSource = self
        TrainningTableView.delegate = self
        
        /*
        let query = NCMBQuery(className: "Trainning")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error)
            } else {
                self.trainningArray = result as! [NCMBObject]
            }
        })
        */

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Trainning.selectedTrainning.title != nil{
            menuButton.setTitle(Trainning.selectedTrainning.title, for: .normal)
        } else {
            menuButton.setTitle("menuを選択", for: .normal)
        }
        menuButton.setTitle(Trainning.selectedTrainning.title, for: .normal)
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
        
       
        /*if (menuButton.currentTitle != nil) && (countTextField.text != nil) && (setTextField.text != nil) && (weightTextField.text != nil) {
            var addTrainning = menuButton.currentTitle!+"を"+countTextField.text!+"回"+setTextField.text!+"セット"+weightTextField.text!+"kg"
        } else if (menuButton.currentTitle != nil) && (countTextField.text != nil) && (setTextField.text != nil) && (weightTextField.text == nil){
            var addTrainning = menuButton.currentTitle!+"を"+countTextField.text!+"回"+setTextField.text!+"セット"
        }else {
            
        }*/
        
        let addTrainning = menuButton.currentTitle!+"を"+countTextField.text!+"回"+setTextField.text!+"セット"+weightTextField.text!+"kg"
        
        trainningArray.append(addTrainning)
        TrainningTableView.reloadData()
        menuButton.setTitle("menuを選択", for: .normal)
        
    }
    
    @IBAction func done() {
        
        let date = dateTextField.text!
        trainningArray.insert(date, at: 0)
        
        print(daylytrainningArray)
        daylytrainningArray.append(contentsOf: trainningArray)
        print(daylytrainningArray)
        
        
        let ud = UserDefaults.standard
        ud.set(daylytrainningArray, forKey: "daylytrainningArray")
        ud.synchronize()
        
        
        self.dismiss(animated: true, completion: nil)
        Trainning.selectedTrainning.title = "menuを選択"
        trainningArray.removeAll()
    }
    
    @IBAction func cancel() {
        
        self.dismiss(animated: true, completion: nil)
        trainningArray.removeAll()
        Trainning.selectedTrainning.title = "menuを選択"

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainningArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainningCell")!
        cell.textLabel?.text = trainningArray[indexPath.row]
        return cell
    }
    
    
    
}
