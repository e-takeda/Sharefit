//
//  MyTrainningViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class MyTrainningViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    var daylyTrainning = [String]()
    var daylyTrainning1 = [String]()
    
    @IBOutlet var MyTrainningTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバーのタイトルのフォントと色変更
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Cochin", size: 20)!]
        
        
        MyTrainningTableView.dataSource = self
        MyTrainningTableView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        load()
        print(daylyTrainning)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daylyTrainning.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTrainningCell")!
        cell.textLabel?.text = daylyTrainning[indexPath.row]

        return cell
    }
    
    func load() {
        let ud = UserDefaults.standard
        if ud.array(forKey: "daylytrainningArray") != nil{
            daylyTrainning = ud.array(forKey: "daylytrainningArray") as! [String]
        }
        //daylyTrainning1.insert(contentsOf: daylyTrainning, at: 0)
        MyTrainningTableView.reloadData()
    }
    
    
}
