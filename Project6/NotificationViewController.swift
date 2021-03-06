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
    @IBOutlet weak var tabItem: UITabBarItem!
    
    
    //likes
    var firstUserNameBox = [String]()
    var userImageURLBox = [String]()
    var userPostTitleBox = [String]()
    var currentUserIdNumberBox = [String]()
    var userPhotoURLBox = [String]()
    var likeBool = false
    var followBool = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let tabItem = self.tabBarController?.tabBar.items?[2] {
            tabItem.badgeColor = UIColor.red
        }
        
        
        /*
         let userDefaults = UserDefaults.standard
         userDefaults.removeObject(forKey: "previousCounts")
         
         if (userDefaults.object(forKey: "previousCounts") != nil) {
         print("データ有り")
         } else {
         print("なし")
         }
        
        */
        
        notificationTable.delegate = self
        notificationTable.dataSource = self
        
        
        
        // フォント種をTime New Roman、サイズを10に指定
        self.navigationItem.title = "アクティビティ"
        
        // フォント種をTime New Roman、サイズを10に指定
        self.navigationController?.navigationBar.titleTextAttributes
            = [NSFontAttributeName: UIFont(name: "Times New Roman", size: 18)!]
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        
        //self.notificationTable.refreshControl = UIRefreshControl()
        //self.notificationTable.refreshControl?.addTarget(self, action: #selector(NotificationViewController.refresh), for: .valueChanged)
        
        
        let currentCounts = self.firstUserNameBox.count
        
        
        //ユーザーデータの読み込みと通知設定
        
        var anonymousUser = currentUserCheck!.isAnonymous
        
        if anonymousUser == true {
            //ゲストユーザー
            
            
            
            
            
        } else if anonymousUser == false {
            //ログインユーザーの場合
            
            
            self.firstUserNameBox = []
            self.userPhotoURLBox = []
            self.userPostTitleBox = []
            self.currentUserIdNumberBox = []
            self.userPhotoURLBox = []

            
            
            
           
            //ユーザの投稿を取得
            DataService.dataBase.REF_BASE.child("users").queryOrdered(byChild: "uid").queryEqual(toValue: FIRAuth.auth()?.currentUser?.uid).observe(.value, with: { (snapshot) in
                
                
                
                self.firstUserNameBox = []
                
                if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    
                    //繰り返し
                    for snap in snapshot {
                        
                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                            
                            if postDict["following"] as? Dictionary<String,String > != nil {
                                
                                
                                let following = postDict["following"] as? Dictionary<String,String >
                                
                                
                            
                                for (_,value) in following! {
                                
                                    //valueのuidからuser情報取得
                                    
                                    DataService.dataBase.REF_BASE.child("users").queryOrdered(byChild: "uid").queryEqual(toValue: value).observe(.value, with: { (snapshot) in
                                        //self.firstUserNameBox = []
                                        //self.userPhotoURLBox = []
                                        
                                        
                                        if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                                            
                                            for snap in snapshot {
                                                
                                                if let postDict = snap.value as? Dictionary<String, AnyObject> {
                                                    
                                                    let userName = postDict["userName"] as? String
                                                    let userimage = postDict["userImageURL"] as? String
                                                    let image = ""
                                                    let postTItle = ""
                                                    let keyUID = ""
                                                    let photoURLL = ""
                                                    
                                                    
                                                    
                                                    self.firstUserNameBox.append(userName!)
                                                    self.userImageURLBox.append(image)
                                                    self.userPhotoURLBox.append(userimage!)
                                                    self.userPostTitleBox.append(postTItle)
                                                    self.currentUserIdNumberBox.append(keyUID)
                                                    
                                                   
                                                    
                                                    self.followBool = true
                                                    
                                                    
                                                    
                                                  
                                                }
                                                
                                            }
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    })
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                            }
                            }
                            
                            
                            
                            
                            if postDict["posts"] as? Dictionary<String, Dictionary<String, AnyObject?>> != nil {
                                
                                
                                
                                let posty = postDict["posts"] as! Dictionary<String, Dictionary<String, AnyObject>>
                                
                                if postDict["posts"] as? Dictionary<String, AnyObject?> != nil {
                                    
                                    let posty = postDict["posts"] as? Dictionary<String, AnyObject?>
                                    
                                    
                                    for (followKey,followValue) in posty! {
                                        
                                        
                                        if followValue?["peopleWhoLike"] as? Dictionary<String, AnyObject?> != nil {
                                            
                                            
                                            
                                            let peopleWhoLiked = followValue?["peopleWhoLike"] as? Dictionary<String, AnyObject?>
                                            
                                            
                                            for (likeKey,likeValue) in peopleWhoLiked! {
                                                
                                                
                                                
                                                let userImageURL = likeValue?["imageURL"] as! String
                                                let photosURL = likeValue?["userProfileURL"] as! String
                                                let userPostTitle = likeValue?["postName"] as! String
                                                let currentUserKeyId = likeValue?["currentUserID"] as! String
                                                
                                                
                                                
                                                self.firstUserNameBox.append(likeKey)
                                                self.userImageURLBox.append(userImageURL)
                                                self.userPostTitleBox.append(userPostTitle)
                                                self.currentUserIdNumberBox.append(currentUserKeyId)
                                                self.userPhotoURLBox.append(photosURL)
                                                
                                                self.likeBool = true
                                                
                                               
                                                
                                            }
                                            
                                           
                                        }
                                        
                                        
                                    }
                                    
                                }
 
                                
                                
                                
                                
                                
                            }
                        }
                    }
                    
                                
                }
                
            
            
                   
                            })
            
            
            
            
            self.wait( {self.followBool == false} ) {
                
                self.wait( {self.likeBool == false} ) {
                    
                    self.firstUserNameBox.reverse()
                    self.userImageURLBox.reverse()
                    self.userPostTitleBox.reverse()
                    self.currentUserIdNumberBox.reverse()
                    self.userPhotoURLBox.reverse()
                    
                   
                    
                    
                    self.notificationTable.reloadData()

                    self.followBool = false
                    self.likeBool = false
                    
                    
                }
                
                
            }
            
                
                
                
                
            }
            
            

            
            
            
            
            
            
            //通知設定
        
            ////初回時通知数を登録
            
            if UserDefaults.standard.object(forKey: "previousCounts") == nil  {
             
                print("初回いいね数を登録しました")
                UserDefaults.standard.set(self.firstUserNameBox.count, forKey: "previousCounts")
                
                
                
            }
            
        
            
 
    }
    
    
    
    
    let currentUserCheck = FIRAuth.auth()?.currentUser
    
    
    
     var detailUserID: String?
     var detailUserName: String?
     var detailUserPhotoURL: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailUserID = self.currentUserIdNumberBox[indexPath.row]
        detailUserName = self.firstUserNameBox[indexPath.row]
        detailUserPhotoURL = self.userPhotoURLBox[indexPath.row]
        
        performSegue(withIdentifier: "tousers", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "tousers" {
            
            let userVC = (segue.destination as? UserViewController)!
            
            userVC.userName = detailUserName
            userVC.userImageURL = detailUserPhotoURL
            userVC.userID = detailUserID
            
            
        }
        
        
        
       
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstUserNameBox.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let notiCell = notificationTable.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as? NotificationTableViewCell
        
        
        notiCell?.userImage.image = nil
        
        let currentCounts = self.firstUserNameBox.count
        
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorInset = .zero
        tableView.separatorColor = UIColor.white
        
        notiCell?.layer.borderColor = UIColor.clear.cgColor
        notiCell?.layer.borderWidth = 10
        notiCell?.clipsToBounds = true
        notiCell?.layer.masksToBounds = true
        notiCell?.layer.cornerRadius = 5.0
        
        
        
        if firstUserNameBox.count >= 1 {
            
            
            if UserDefaults.standard.object(forKey: "previousCounts") != nil {
                
                print("通知数の検証をします")
                //前回数値を取得
                let previousNum = UserDefaults.standard.integer(forKey: "previousCounts")
                print(previousNum)
                print(currentCounts)
                
                //今回と比較 大きければ、バッジに表示とpreviousの更新
                if currentCounts > previousNum {
                    print("最終")
                    let currentNum = currentCounts - previousNum
                    print(currentNum)
                    
                    
                    if let tabItem = self.tabBarController?.tabBar.items?[2] {
                        tabItem.badgeColor = UIColor.red
                        tabItem.badgeValue = String(currentNum)
                    }
                    
                    //self.tabItem.badgeValue = String(currentNum)
                    
                    let userDefaults = UserDefaults.standard
                    
                    userDefaults.removeObject(forKey: "previousCounts")
                    
                    UserDefaults.standard.set(self.firstUserNameBox.count, forKey: "previousCounts")
                    print("通知数が更新されました")
                    
                    
                }
                
 
                
                
            }
 
            
            
        }
        
        
        
        
        let check = userPostTitleBox[indexPath.row]
        if check == "" {
            
            notiCell?.userImage.af_setImage(withURL: URL(string: userPhotoURLBox[indexPath.row])!)
            notiCell?.title.text = firstUserNameBox[indexPath.row]
            notiCell?.reactMessage.text = "さんがあなたをフォローしています"
            
        } else {
            
            notiCell?.userName.text = firstUserNameBox[indexPath.row]
            notiCell?.userImage.af_setImage(withURL: URL(string: userImageURLBox[indexPath.row])!)
            notiCell?.title.text = userPostTitleBox[indexPath.row]
            notiCell?.reactMessage.text = "さんがいいねと言っています"
            
            
        }
        
        
        
        
        return notiCell!
        
        
       
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    func wait(_ waitContinuation: @escaping (()->Bool), compleation: @escaping (()->Void)) {
        var wait = waitContinuation()
        
        
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            while wait {
                DispatchQueue.main.async {
                    wait = waitContinuation()
                    semaphore.signal()
                }
                semaphore.wait()
                Thread.sleep(forTimeInterval: 0.01)
            }
            
            
            DispatchQueue.main.async {
                compleation()
                
                
                
            }
        }
    }
        

}

