//
//  MyTrainningViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class MyTrainningViewController: UIViewController ,UITableViewDataSource{
    
    
    @IBOutlet var MyTrainningTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバーのタイトルのフォントと色変更
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Cochin", size: 20)!]
        
        
        MyTrainningTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTrainningCell")!
        cell.textLabel?.text = "a"
        
        
        return cell
    }
    
}
