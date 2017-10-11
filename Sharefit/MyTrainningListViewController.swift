//
//  MyTrainningListViewController.swift
//  Sharefit
//
//  Created by 武田　瑛璃 on 2017/10/11.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB

class MyTrainningListViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    var sample = [Trainning]()
    var menu = [NCMBObject]()
    
    @IBOutlet var MyTrainningListTableView :UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバーのタイトルのフォントと色変更
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Cochin", size: 20)!]
        
        MyTrainningListTableView.delegate = self
        MyTrainningListTableView.dataSource = self
        
        let query = NCMBQuery(className: "Menu")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error)
            } else {
                self.menu = result as! [NCMBObject]
            }
        })
    }
    
    @IBAction func cancel() {
    self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTrainningListCell")!
        cell.textLabel?.text = menu[indexPath.row].object(forKey: "menu") as! String
        
        
        return cell
    }

    
    
    
    

}
