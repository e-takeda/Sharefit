
//
//  TrainningListViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/10/04.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit

class TrainningListVvarController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    var sample = [Trainning]()
    
    @IBOutlet var trainningListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let training1 = Trainning()
        training1.title = "腕立て"
        training1.count = 10
        sample.append(training1)
        let training2 = Trainning()
        training2.title = "腹筋"
        training2.count = 10
        sample.append(training2)
        
        
        trainningListTableView.dataSource = self
        trainningListTableView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainningListCell")!
        cell.textLabel?.text = sample[indexPath.row].title

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Tap
        Trainning.selectedTrainning = sample[indexPath.row]
        self.navigationController?.popViewController(animated: true)
    }






}
