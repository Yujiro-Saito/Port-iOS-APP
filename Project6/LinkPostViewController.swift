//
//  LinkPostViewController.swift
//  Project6
//
//  Created by  Yujiro Saito on 2017/09/06.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage
import Eureka
//import SkyFloatingLabelTextField

class LinkPostViewController: FormViewController {
    
    
    //データ
    var folderName = String()
    let uid = FIRAuth.auth()?.currentUser?.uid
    let userName = FIRAuth.auth()?.currentUser?.displayName
    var folderInfo = Dictionary<String,String>()
    
    //投稿ボタン
    func postButtonDidTap(){
        
        let linkRow: TextRow? = form.rowBy(tag: "link")
        let linkValue = linkRow?.value
        
        let captionRow: TextRow? = form.rowBy(tag: "memo")
        var captionValue = captionRow?.value

        
        if linkValue == nil {
            
            let alertViewControler = UIAlertController(title: "リンク", message: "リンクは必須です", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertViewControler.addAction(okAction)
            self.present(alertViewControler, animated: true, completion: nil)
            
            
        } else if captionValue == nil {
            
            captionValue = ""
            
            
            
            showIndicator()
            
            
            if self.isImage == false {
                 self.folderInfo = ["imageURL" : self.imageURL, "name" : self.folderName]
            } else if self.isImage == true {
                
                 self.folderInfo = ["imageURL" : self.imageURL, "name" : self.folderName]
                
            }
            
            
            let folderNameDictionary: Dictionary<String, Dictionary<String, String?>> = [self.folderName : folderInfo]
            
            
            let firebasePost = DataService.dataBase.REF_USER.child(uid!).child("posts").childByAutoId()
            let key = firebasePost.key
            let keyvalue = ("\(key)")
            
            let post: Dictionary<String, AnyObject> = [
                
                "folderName" :  folderName as AnyObject,
                "linkURL" : linkValue! as AnyObject,
                "pvCount" : 0 as AnyObject,
                "userID" : uid as AnyObject,
                "userName" : userName as AnyObject,
                "name" : captionValue! as AnyObject,
                "imageURL" : self.imageURL as AnyObject,
                "postID" : keyvalue as AnyObject
            ]
            
            
            firebasePost.setValue(post)
            DataService.dataBase.REF_BASE.child("users/\(uid!)/folderName").updateChildValues(folderNameDictionary)
            
            DispatchQueue.main.async {
                
                self.indicator.stopAnimating()
            }
            
            let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                self.performSegue(withIdentifier: "DoneLink", sender: nil)
            })
            
            
            
        } else {
            
            
            
            showIndicator()
            
            if self.isImage == false {
                self.folderInfo = ["imageURL" : self.imageURL, "name" : self.folderName]
            } else if self.isImage == true {
                
                self.folderInfo = ["imageURL" : self.imageURL, "name" : self.folderName]
                
            }
            
            
            let folderNameDictionary: Dictionary<String, Dictionary<String, String?>> = [self.folderName : folderInfo]
            
            let firebasePost = DataService.dataBase.REF_USER.child(uid!).child("posts").childByAutoId()
            let key = firebasePost.key
            let keyvalue = ("\(key)")
            
            let post: Dictionary<String, AnyObject> = [
                
                "folderName" :  folderName as AnyObject,
                "linkURL" : linkValue! as AnyObject,
                "pvCount" : 0 as AnyObject,
                "userID" : uid as AnyObject,
                "userName" : userName as AnyObject,
                "name" : captionValue! as AnyObject,
                "imageURL" : self.imageURL as AnyObject,
                "postID" : keyvalue as AnyObject
            ]
            
            
            firebasePost.setValue(post)
            DataService.dataBase.REF_BASE.child("users/\(uid!)/folderName").updateChildValues(folderNameDictionary)
            
            
            DispatchQueue.main.async {
                
                self.indicator.stopAnimating()
            }
            
            let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                self.performSegue(withIdentifier: "DoneLink", sender: nil)
            })
            
            
        }
        
    
    }
    
    var isImage = Bool()
    var imageURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.dataBase.REF_BASE.child("users").child(uid!).child("folderName").queryOrdered(byChild: "name").queryEqual(toValue: folderName).observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshot {
                    
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        print(postDict)
                        
                        let itemURL = postDict["imageURL"] as! String
                        
                        if itemURL == "" {
                            self.isImage = false
                            self.imageURL = ""
                            
                        } else if itemURL != "" {
                            self.isImage = true
                            self.imageURL = itemURL
                            
                        }
                        
                        
                    }
                    
                }
                
                
            }
            
            
        })
        
        let rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(LinkPostViewController.postButtonDidTap))
        self.navigationItem.setRightBarButtonItems([rightSearchBarButtonItem], animated: true)
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.hidesBarsOnSwipe = true
        tableView.backgroundColor = UIColor.rgb(r: 69, g: 113, b: 144, alpha: 1.0)
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        form +++ Section("登録")
            <<< TextRow("link"){ row in
                row.title = "リンク"
                row.placeholder = "コピーしたリンク(必須)"
            }
            <<< TextRow("memo"){ row in
                row.title = "メモ"
                row.placeholder = "メモ(任意)"
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    let indicator = UIActivityIndicatorView()
    
    func showIndicator() {
        
        indicator.activityIndicatorViewStyle = .white
        
        indicator.center = self.view.center
        
        indicator.color = UIColor.white
        
        indicator.hidesWhenStopped = true
        
        self.view.addSubview(indicator)
        
        self.view.bringSubview(toFront: indicator)
        
        indicator.startAnimating()
        
    }


}