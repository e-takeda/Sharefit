//
//  ViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/08/23.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB
import Kingfisher
import SVProgressHUD

class ViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    
    var selectedPost: Post?
    var posts = [Post]()
    
    @IBOutlet var timelineTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバーのタイトルのフォントと色変更
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Cochin", size: 20)!]
        
        timelineTableView.dataSource = self
        timelineTableView.delegate = self
        
        let nib = UINib(nibName: "TimelineTableViewCell", bundle: Bundle.main)
        timelineTableView.register(nib, forCellReuseIdentifier: "Cell")
        
        timelineTableView.tableFooterView = UIView()
        
         // 引っ張って更新
        setRefreshControl()
        
        loadTimeline()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TimelineTableViewCell
        
        //cell.delegate = self
        cell.tag = indexPath.row
        
        let user = posts[indexPath.row].user
        cell.userNameLabel.text = user.displayName
        let userImageUrl = "https://mb.api.cloud.nifty.com/2013-09-01/applications/DoSWmydfKRGx9uj/publicFiles/" + user.objectId
        cell.userImageView.kf.setImage(with: URL(string: userImageUrl))
        
        cell.commentTextView.text = posts[indexPath.row].text
        let imageUrl = posts[indexPath.row].imageUrl
        cell.photoImageView.kf.setImage(with: URL(string: imageUrl))
        
        /*// Likeによってハートの表示を変える
        if posts[indexPath.row].isLiked == true {
            cell.likeButton.setImage(UIImage(named: "heart-fill"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(named: "heart-outline"), for: .normal)
        }
 */
        
        return cell
    }



    
    
    
    
    
    func loadTimeline() {
        let query = NCMBQuery(className: "Post")
        
        // 降順
        query?.order(byDescending: "createDate")
        // 投稿したユーザーの情報も同時取得
        query?.includeKey("user")
        
        // オブジェクトの取得
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error)
            } else {
                // 投稿を格納しておく配列を初期化(これをしないとreload時にappendで二重に追加されてしまう)
                self.posts = [Post]()
                
                for postObject in result as! [NCMBObject] {
                    // ユーザー情報をUserクラスにセット
                    let user = postObject.object(forKey: "user") as! NCMBUser
                    
                    // 退会済みユーザーの投稿を避けるため、userが存在しているかnilチェック
                    if user.objectId != nil {
                        let userModel = User(objectId: user.objectId, userName: user.userName)
                        userModel.displayName = user.object(forKey: "displayName") as? String
                        
                        // 投稿の情報を取得
                        let imageUrl = postObject.object(forKey: "imageUrl") as! String
                        let text = postObject.object(forKey: "text") as! String
                        
                        // 2つのデータ(投稿情報と誰が投稿したか?)を合わせてPostクラスにセット
                        let post = Post(objectId: postObject.objectId, user: userModel, imageUrl: imageUrl, text: text, createDate: postObject.createDate)
                        
                        // likeの状況(自分が過去にLikeしているか？)によってデータを挿入
                        let likeUser = postObject.object(forKey: "likeUser") as? [String]
                        if likeUser?.contains(NCMBUser.current().objectId) == true {
                            post.isLiked = true
                        } else {
                            post.isLiked = false
                        }
                        // 配列に加える
                        self.posts.append(post)
                    }
                    
                }
                
                // 投稿のデータが揃ったらTableViewをリロード
                self.timelineTableView.reloadData()
            }
        })
    }

    
    
    
    
    
    
    
    func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadTimeline(refreshControl:)), for: .valueChanged)
        timelineTableView.addSubview(refreshControl)
    }
    
    func reloadTimeline(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        self.loadTimeline()
        // 更新が早すぎるので2秒遅延させる
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            refreshControl.endRefreshing()
        }
    }
}

