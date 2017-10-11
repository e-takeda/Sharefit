
//
//  TrainningListViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB


class TrainningListViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    var sample = [Trainning]()
    var menu = [NCMBObject]()
    
    @IBOutlet var trainningListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let training1 = Trainning()
        training1.title = "腕立て"
        training1.count = 10
        sample.append(training1)
        */
        
        trainningListTableView.dataSource = self
        trainningListTableView.delegate = self
        
        
        let query = NCMBQuery(className: "Menu")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error)
            } else {
                self.menu = result as! [NCMBObject]
                self.trainningListTableView.reloadData()
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainningListCell")!
        cell.textLabel?.text = menu[indexPath.row].object(forKey: "menu") as! String

        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Tap
        Trainning.selectedTrainning.title = menu[indexPath.row].object(forKey: "menu") as! String
        self.navigationController?.popViewController(animated: true)
    }






}
