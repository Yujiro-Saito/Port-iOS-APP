//
//  NotificationViewController.swift
//  Project6
//
//  Created by  Yujiro Saito on 2017/07/09.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage

class NotificationViewController: UIViewController ,UINavigationBarDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var notificationTable: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    var firstUserNameBox = [String]()
    var userImageURLBox = [String]()
    var userPostTitleBox = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.delegate = self
        notificationTable.delegate = self
        notificationTable.dataSource = self
        
        
        //バーの高さ
        self.navBar.frame = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.size.width, height: 60)
        
        self.view.bringSubview(toFront: navBar)
        
        self.notificationTable.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        self.notificationTable.refreshControl = UIRefreshControl()
        self.notificationTable.refreshControl?.addTarget(self, action: #selector(NotificationViewController.refresh), for: .valueChanged)
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        
        //ユーザの投稿を取得
        DataService.dataBase.REF_BASE.child("posts").queryOrdered(byChild: "userID").queryEqual(toValue: FIRAuth.auth()?.currentUser?.uid).observe(.value, with: { (snapshot) in
            
            self.firstUserNameBox = []
            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                //繰り返し
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        
                        //投稿にいいねをつけている人がいる場合
                        if let peopleWhoLike = postDict["peopleWhoLike"] as? Dictionary<String, AnyObject> {
                            
                            print(peopleWhoLike)
                            
                        
                            
                            for (nameKey,namevalue) in peopleWhoLike {
                                print("キーは\(nameKey)、値は\(namevalue)")
                                
                                
                                print("ユーザー画像URLの取得\(namevalue)")
                                
                                
                               
                                let userImageURL = namevalue["imageURL"] as! String
                                
                                 let userPostTitle = namevalue["postName"] as! String
                                
                                
                                self.firstUserNameBox.append(nameKey)
                                self.userImageURLBox.append(userImageURL)
                                self.userPostTitleBox.append(userPostTitle)
                                
                                
                                self.firstUserNameBox.reverse()
                                self.userImageURLBox.reverse()
                                self.userPostTitleBox.reverse()
                                
                                self.notificationTable.reloadData()
                                
                                print(self.firstUserNameBox)
                                print(self.userImageURLBox)
                                
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                        }
 
 
 
                        
                        
                        
                        
                        
                        
                        
                        
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                
            
            
            
            
            
            
            
 
            
            
        })
        
        
        
        
    }



    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstUserNameBox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let notiCell = notificationTable.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as? NotificationTableViewCell
        
        
        notiCell?.layer.borderColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0).cgColor
        notiCell?.layer.borderWidth = 10
        notiCell?.clipsToBounds = true
        
        if firstUserNameBox.count >= 1 {
            notiCell?.userName.text = firstUserNameBox[indexPath.row]
            notiCell?.userImage.af_setImage(withURL: URL(string: userImageURLBox[indexPath.row])!)
            notiCell?.title.text = userPostTitleBox[indexPath.row]
        }
        
        
        
        
        
        
       
 
        
        return notiCell!
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func refresh() {
        
        
        //ユーザの投稿を取得
        DataService.dataBase.REF_BASE.child("posts").queryOrdered(byChild: "userID").queryEqual(toValue: FIRAuth.auth()?.currentUser?.uid).observe(.value, with: { (snapshot) in
            
            self.firstUserNameBox = []
            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                //繰り返し
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        
                        //投稿にいいねをつけている人がいる場合
                        if let peopleWhoLike = postDict["peopleWhoLike"] as? Dictionary<String, AnyObject> {
                            
                            print(peopleWhoLike)
                            
                            
                            
                            for (nameKey,namevalue) in peopleWhoLike {
                                print("キーは\(nameKey)、値は\(namevalue)")
                                
                                
                                print("ユーザー画像URLの取得\(namevalue)")
                                
                                
                                
                                let userImageURL = namevalue["imageURL"] as! String
                                
                                let userPostTitle = namevalue["postName"] as! String
                                
                                
                                self.firstUserNameBox.append(nameKey)
                                self.userImageURLBox.append(userImageURL)
                                self.userPostTitleBox.append(userPostTitle)
                                
                                
                                self.firstUserNameBox.reverse()
                                self.userImageURLBox.reverse()
                                self.userPostTitleBox.reverse()
                                
                                self.notificationTable.reloadData()
                                
                                print(self.firstUserNameBox)
                                print(self.userImageURLBox)
                                
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
        })
        
        self.notificationTable.refreshControl?.endRefreshing()
        

    
}

}

