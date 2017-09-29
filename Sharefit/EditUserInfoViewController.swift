//
//  EditUserInfoViewController.swift
//  Sharefit
//
//  Created by nttr on 2017/09/25.
//  Copyright © 2017年 nttr. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit

class EditUserInfoViewController: UIViewController ,UITextFieldDelegate ,UITextViewDelegate ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var introductionTextView: UITextView!

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Cochin", size: 20)!]
        
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
        
        userNameTextField.delegate = self
        userIdTextField.delegate = self
        introductionTextView.delegate = self
        
        let userId = NCMBUser.current().userName
        userIdTextField.text = userId
        
        let file = NCMBFile.file(withName: NCMBUser.current().objectId, data: nil) as! NCMBFile
        file.getDataInBackground { (data, error) in
            if error != nil {
                let alert = UIAlertController(title: "画像取得エラー", message: error!.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                if data != nil {
                    let image = UIImage(data: data!)
                    self.userImageView.image = image
                    
                }
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let resizedImage = selectedImage.scale(byFactor: 0.4)
        
        picker.dismiss(animated: true, completion: nil)
        
        let data = UIImagePNGRepresentation(resizedImage!)
        let file = NCMBFile.file(withName: NCMBUser.current().objectId, data: data) as! NCMBFile
        file.saveInBackground({ (error) in
            if error != nil {
                let alert = UIAlertController(title: "画像アップロードエラー", message: error!.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.userImageView.image = selectedImage
            }
        }) { (progress) in
            print(progress)
        }
    }

    
    
    
    @IBAction func selectImage() {
        let actionController = UIAlertController(title: "画像の選択", message: "選択して下さい", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            // カメラ起動
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではカメラが使用出来ません。")
            }
        }
        let albumAction = UIAlertAction(title: "フォトライブラリ", style: .default) { (action) in
            // アルバム起動
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            } else {
                print("この機種ではフォトライブラリが使用出来ません。")
            }
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            actionController.dismiss(animated: true, completion: nil)
        }
        actionController.addAction(cameraAction)
        actionController.addAction(albumAction)
        actionController.addAction(cancelAction)
        self.present(actionController, animated: true, completion: nil)
    }

    
    @IBAction func closeEditViewController() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveUserInfo() {
        let user = NCMBUser.current()
        user?.setObject(userNameTextField.text, forKey: "displayName")
        user?.setObject(userIdTextField.text, forKey: "userName")
        user?.setObject(introductionTextView.text, forKey: "introduction")
        user?.saveInBackground({ (error) in
            if error != nil {
                let alert = UIAlertController(title: "送信エラー", message: error!.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }

    
    
    
}
