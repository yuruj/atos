//
//  ChangeHeadPortraitViewController.swift
//  atos
//
//  Created by 余润杰 on 2021/4/7.
//

import UIKit

class ChangeHeadPortraitViewController: UIViewController {
    
    lazy var imageView = { () -> UIImageView in
        let tp = UIImageView()
        return tp
    } ()
    
    lazy var imagePicker = { () -> UIImagePickerController in
        let tp = UIImagePickerController()
        tp.delegate = self
        return tp
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
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
