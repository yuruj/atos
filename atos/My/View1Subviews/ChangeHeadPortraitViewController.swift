//
//  ChangeHeadPortraitViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/7.
//

import UIKit

class ChangeHeadPortraitViewController: UIViewController {
    
    lazy var imageView = { () -> UIImageView in
        let tp = UIImageView(image: UIImage(named: "hp"))
        tp.frame = CGRect(x: 0, y: navHeight, width: screenSize.width, height: screenSize.width)
        tp.contentMode = .scaleAspectFit
        return tp
    } ()
    
    lazy var imagePicker = { () -> UIImagePickerController in
        let tp = UIImagePickerController()
        tp.delegate = self
        return tp
    } ()
    
    lazy var changeBtn = { () -> UIButton in
        let tp = UIButton()
        tp.setTitle("更换头像", for: .normal)
        tp.setTitleColor(UIColor.black, for: .normal)
        tp.backgroundColor = nil
        tp.frame = CGRect(x: screenSize.width / 2 - 50, y: screenSize.width + 20 + navHeight, width: 100, height: 40)
        tp.addTarget(self, action: #selector(openAlbum), for: .touchUpInside)
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        self.view.addSubview(changeBtn)
    }
    
    @objc func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            NSLog("----可以打开摄像头----")
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            NSLog("----无法打开摄像头----")
        }
    }
    
    @objc func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            NSLog("----可以打开相册----")
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            NSLog("----无法打开相册----")
        }
    }
    
}

extension ChangeHeadPortraitViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
