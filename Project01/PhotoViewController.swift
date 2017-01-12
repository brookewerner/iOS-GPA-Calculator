//
//  PhotoViewController.swift
//  Project01
//
//  Created by Brooke Werner on 11/29/16.
//  Copyright © 2016 Brooke Werner. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var urlField: UITextField!
    var encoder: Encoder!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var libraryButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    var imageFetcher: ImageFetcher!
    @IBOutlet var fetchImageButton: UIBarButtonItem!

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        ImageHelper.saveImage(photo, forUID: encoder.aUniqueID)

        imageView.image = photo
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            encoder.imageSource = "camera"
        }

        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func choosePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            picker.sourceType = .photoLibrary
            encoder.imageSource = "lib"

        }
        
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)

    }
    
    
    @IBAction func fetchImage(_ sender: Any) {
        let url = urlField.text!
        
        imageFetcher.fetchImage(url: url) {
            (fetchResult) -> Void in
            
            switch(fetchResult) {
            case let .ImageSuccess(image):
                OperationQueue.main.addOperation() {
                    self.imageView.image = image
                    self.encoder.photoUrl = url
                    self.encoder.imageSource = "textfield"
                }
            case let .ImageFailure(error):
                OperationQueue.main.addOperation() {
                    print("oops!!!!!")
                }
                print("error: \(error)")
            }
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) { //the keyboard is dismissed if the user clicks out of the text field
        urlField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myApp = UIApplication.shared
        
        let myDelegate = myApp.delegate as! AppDelegate
        
        encoder = myDelegate.encoder
        
        if let img = ImageHelper.getImage(forUID: encoder.aUniqueID) {
            imageView.image = img
        }
        
        if !(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            cameraButton.isEnabled = false
        } else {
            cameraButton.isEnabled = true
        }
        
        imageFetcher = ImageFetcher()
        
        urlField.text = encoder.photoUrl
        
        let lastImageSource = encoder.imageSource
        
        if (lastImageSource == "textfield") {
            if let textInTextField = urlField.text {
                if (!textInTextField.isEmpty) {
                    fetchImage(fetchImageButton)
                }
            }
        }

    }

}
