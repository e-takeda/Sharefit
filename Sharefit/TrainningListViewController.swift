
//
//  TrainningListViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class TrainningListViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    
    
    @IBOutlet var trainningListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        trainningListTableView.dataSource = self
        trainningListTableView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainningListCell")!
        cell.textLabel?.text = "a"
        
        
        return cell
    }







}
