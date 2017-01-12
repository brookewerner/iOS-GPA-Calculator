//
//  BrowserViewController.swift
//  Project01
//
//  Created by Brooke Werner on 12/6/16.
//  Copyright © 2016 Brooke Werner. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var urlField: UITextField!
    var encoder: Encoder!
    @IBOutlet var goButton: UIButton!
    
    @IBAction func go(_ sender: Any) {
        let urlString = urlField.text!
        
        if (urlString.hasPrefix("https://") || urlString.hasPrefix("http://")) {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
                encoder.browserUrl = urlString
            }else {
                print("Inavlid url: \(urlString)")
            }
        } else {
            let searchString = urlString.replacingOccurrences(of: " ", with: "%20")
            if let url = URL(string: "https://www.google.com/search?q=\(searchString)") {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
                encoder.browserUrl = (urlString)
            } else {
                print("Inavlid url: \(urlString)")
            }
        }

    }
    
    @IBAction func stop(_ sender: Any) {
        webView.stopLoading()
    }
    
    @IBAction func reload(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func forward(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func back(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) { //the keyboard is dismissed if the user clicks out of the text field
        urlField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let myApp = UIApplication.shared
        
        let myDelegate = myApp.delegate as! AppDelegate
        
        encoder = myDelegate.encoder
        
        urlField.text = encoder.browserUrl
        
        if let textInTextField = urlField.text {
            if (!textInTextField.isEmpty) {
                go(goButton)
            }
        }

    }
}
