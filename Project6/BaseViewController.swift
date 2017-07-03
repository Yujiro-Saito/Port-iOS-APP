//
//  BaseViewController.swift
//  Project6
//
//  Created by  Yujiro Saito on 2017/06/27.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit
import Firebase

class BaseViewController: UIViewController,UINavigationBarDelegate,UICollectionViewDelegate, UICollectionViewDataSource {
    
    //Outlet
    @IBOutlet weak var baseNavBar: UINavigationBar!
    @IBOutlet weak var topCollectionTable: UICollectionView!
    @IBOutlet weak var firstCollection: UICollectionView!
    @IBOutlet weak var secondCollection: UICollectionView!
    @IBOutlet weak var thirdCollection: UICollectionView!
    @IBOutlet weak var fourthCollection: UICollectionView!
    @IBOutlet weak var fifthCollection: UICollectionView!
    
    
    
    
    
    
    //プロパティ
    var displayUserName: String?
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var initialURL = URL(string: "")
    
    //コレクションビュー用の配列
    var topPosts = [Post]()
    var firstPosts = [Post]()
    var secondPosts = [Post]()
    var thirdPosts = [Post]()
    var fourthPosts = [Post]()
    var fifthPosts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //DELEGATE
        baseNavBar.delegate = self
        topCollectionTable.delegate = self
        topCollectionTable.dataSource = self
        firstCollection.delegate = self
        firstCollection.dataSource = self
        secondCollection.delegate = self
        secondCollection.dataSource = self
        thirdCollection.delegate = self
        thirdCollection.dataSource = self
        fourthCollection.delegate = self
        fourthCollection.dataSource = self
        fifthCollection.delegate = self
        fifthCollection.dataSource = self
        
        
        //バーの高さ
        self.baseNavBar.frame = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.size.width, height: 60)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //注目のデータ読み込み
        DataService.dataBase.REF_TOP.observe(.value, with: { (snapshot) in
            
            self.topPosts = []
            
            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        
                        self.topPosts.append(post)
                        self.topCollectionTable.reloadData()
                    }
                    
                    
                }
                
                
            }
            
        })
        
        //Firstのデータ読み込み
        DataService.dataBase.REF_FIRST.observe(.value, with: { (snapshot) in
            
            self.firstPosts = []
            
            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        
                        self.firstPosts.append(post)
                        self.firstCollection.reloadData()
                    }
                    
                    
                }
                
                
            }
            
        })
        
        
        
        //Secondのデータ読み込み
        DataService.dataBase.REF_SECOND.observe(.value, with: { (snapshot) in
            
            self.secondPosts = []
            
            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        
                        self.secondPosts.append(post)
                        self.secondCollection.reloadData()
                    }
                    
                    
                }
                
                
            }
            
        })
        
        
        
        
        //Thirdのデータ読み込み
        DataService.dataBase.REF_THIRD.observe(.value, with: { (snapshot) in
            
            self.thirdPosts = []
            
            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        
                        self.thirdPosts.append(post)
                        self.thirdCollection.reloadData()
                    }
                    
                    
                }
                
                
            }
            
        })
        
        
        
        ////Fourthのデータ読み込み
        
        DataService.dataBase.REF_FOURTH.observe(.value, with: { (snapshot) in
            
            self.fourthPosts = []
            
            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        
                        self.fourthPosts.append(post)
                        self.fourthCollection.reloadData()
                    }
                    
                    
                }
                
                
            }
            
        })
        
        
        
        
        
        ////Fifthのデータ読み込み
        
        DataService.dataBase.REF_FIFTH.observe(.value, with: { (snapshot) in
            
            self.fifthPosts = []
            
            print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        
                        self.fifthPosts.append(post)
                        self.fifthCollection.reloadData()
                    }
                    
                    
                }
                
                
            }
            
        })

        
        
        
        
        
        
        
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //ログインしているか確認
        if UserDefaults.standard.object(forKey: "AutoLogin") != nil {
            
            print("自動ログイン")
            
        } else {
            //ログインしていなければ登録画面に戻る
            self.performSegue(withIdentifier: "backtoRegister", sender: nil)
        }
        
        
        if UserDefaults.standard.object(forKey: "GoogleRegister") != nil {
            
            
            
            let alertViewControler = UIAlertController(title: "Welcome!", message: "ありがとうございます", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertViewControler.addAction(okAction)
            self.present(alertViewControler, animated: true, completion: nil)
            
            
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "GoogleRegister")
            
            
        }
        
        
        
        
        if UserDefaults.standard.object(forKey: "EmailRegister") != nil {
            
            
            let alertViewControler = UIAlertController(title: "登録を完了しました", message: "ありがとうございます!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertViewControler.addAction(okAction)
            self.present(alertViewControler, animated: true, completion: nil)
            
            
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "EmailRegister")
            
            //ユーザー登録時のユーザーネーム、アドレスの登録
            let user = FIRAuth.auth()?.currentUser
            
            if let user = user {
                let changeRequest = user.profileChangeRequest()
                
                changeRequest.displayName = "ゲスト"
                changeRequest.photoURL = self.initialURL
                
                changeRequest.commitChanges { error in
                    if let error = error {
                        // An error happened.
                        print(error.localizedDescription)
                    } else {
                        print("プロフィールの登録完了")
                        print(user.displayName!)
                        print(user.email!)
                    }
                }
            }
            
        }
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == topCollectionTable {
            //Top記事のセル
            let topCell = topCollectionTable.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as? newCollectionViewCell
            
            
            let post = topPosts[indexPath.row]
            
            
            if let img = BaseViewController.imageCache.object(forKey: post.imageURL as NSString) {
                topCell?.configureCell(post: post, img: img)
            } else {
                topCell?.configureCell(post: post)
            }
            
            return topCell!
            
        } else if collectionView == firstCollection {
            //一番目の記事のセル
            
            
            let firstCell = firstCollection.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as? FirstCollectionViewCell
            
            let post = firstPosts[indexPath.row]
            
            
            if let img = BaseViewController.imageCache.object(forKey: post.imageURL as NSString) {
                firstCell?.configureCell(post: post, img: img)
            } else {
                firstCell?.configureCell(post: post)
                
                
            }
            
            return firstCell!
            
            
            
            
        } else if collectionView == secondCollection {
            
            //2番目の記事のセル
            
            let secondCell = secondCollection.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as? SecondCollectionViewCell
            
            let post = secondPosts[indexPath.row]
            
            
            if let img = BaseViewController.imageCache.object(forKey: post.imageURL as NSString) {
                secondCell?.configureCell(post: post, img: img)
            } else {
                secondCell?.configureCell(post: post)
                
                
            }
            
            return secondCell!
            

        } else if collectionView == thirdCollection {
            
            //3番目の記事のセル
            
            let thirdCell = thirdCollection.dequeueReusableCell(withReuseIdentifier: "thirdCell", for: indexPath) as? ThirdCollectionViewCell
            
            let post = thirdPosts[indexPath.row]
            
            
            if let img = BaseViewController.imageCache.object(forKey: post.imageURL as NSString) {
                thirdCell?.configureCell(post: post, img: img)
            } else {
                thirdCell?.configureCell(post: post)
                
                
            }
            
            return thirdCell!
            
           
            
        } else if collectionView == fourthCollection {
            
            
            //4番目の記事のセル
            
            let fourthCell = fourthCollection.dequeueReusableCell(withReuseIdentifier: "fourthCell", for: indexPath) as? FourthCollectionViewCell
            
            
            let post = fourthPosts[indexPath.row]
            
            
            if let img = BaseViewController.imageCache.object(forKey: post.imageURL as NSString) {
                fourthCell?.configureCell(post: post, img: img)
            } else {
                fourthCell?.configureCell(post: post)
                
                
            }
            
            
            
            return fourthCell!
            
        } else if collectionView == fifthCollection {
            
            
            //5番目の記事のセル
            let fifthCell = fifthCollection.dequeueReusableCell(withReuseIdentifier: "fifthCell", for: indexPath) as? FifthCollectionViewCell
            
            
            let post = fifthPosts[indexPath.row]
            
            
            if let img = BaseViewController.imageCache.object(forKey: post.imageURL as NSString) {
                fifthCell?.configureCell(post: post, img: img)
            } else {
                fifthCell?.configureCell(post: post)
                
                
            }
            
            
            
            return fifthCell!
            
            
            
        }
        
        
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == topCollectionTable {
            return topPosts.count
        } else if collectionView == firstCollection {
            return firstPosts.count
        } else if collectionView == secondCollection {
            return secondPosts.count
        } else if collectionView == thirdCollection {
            return thirdPosts.count
        } else if collectionView == fourthCollection {
            return fourthPosts.count
        } else if collectionView == fifthCollection {
            return fifthPosts.count
        }
        
        return 1
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
   
}
