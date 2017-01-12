//
//  ViewController.swift
//  Project01
//
//  Created by Brooke Werner on 10/24/16.
//  Copyright © 2016 Brooke Werner. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    var encoder: Encoder!
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var calculateButton: UIButton!
    @IBOutlet var addGradeButton: UIButton!
    var inputGrades: [Float] = [Float]()
//    var numInputGrades: Int = 0
    var gpaCalculator: GPACalculations = GPACalculations()
    @IBOutlet var gpaAmountLabel: UILabel!
    @IBOutlet var gpaLabel: UILabel!
    @IBOutlet var calculateButtonLeadingConstraint: NSLayoutConstraint!
//    @IBOutlet var closeHelp: UIButton!
//    @IBOutlet var helpButton: UIButton!
//    @IBOutlet var helpLabel: UILabel!
    @IBOutlet var creditTextField: UITextField!
    var inputCredits: [Int] = [Int]()
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var photoButton: UIButton!
    @IBOutlet var browserButton: UIButton!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let current = textField.text, !current.isEmpty {
            return string.characters.count == 0
        } else if string.characters.count <= 1 {
            return true
        } else {
            return false
        }
    }
    
//    @IBAction func showHelp(sender: AnyObject){
//        showHelpLabel()
//    }
//    
//    @IBAction func hideHelp(sender: AnyObject) {
//         hideHelpLabel()
//    }
//    
//    @IBAction func showHelpLabel() {
//        UIView.animate(
//            withDuration: 1,
//            delay: 1,
//            options: [],
//            animations: { () -> Void in
//                self.helpLabel.alpha = 1
//                self.closeHelp.alpha = 1
//                self.helpButton.alpha = 0
//            }
//        )
//    }
//    
//    @IBAction func hideHelpLabel() {
//        UIView.animate(
//            withDuration: 1,
//            delay: 1,
//            options: [],
//            animations: { () -> Void in
//                self.helpLabel.alpha = 0
//                self.closeHelp.alpha = 0
//                self.helpButton.alpha = 1
//            }
//        )
//    }

    
    func animateCalculateButton() {
        let width = view.frame.width
        
        calculateButtonLeadingConstraint.constant += width
        
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: { () -> Void in
                self.view.layoutIfNeeded()
            },
            completion: { (Bool) -> Void in
                UIView.animate(
                    withDuration: 2,
                    animations: { () -> Void in
                        self.calculateButtonLeadingConstraint.constant -= width
                        self.view.layoutIfNeeded()
                    })
        })
    }
    
    func animateGpaAmountLabel() {
        UIView.animate(
            withDuration: 1,
            delay: 1,
            options: [],
            animations: { () -> Void in
                self.gpaAmountLabel.alpha = 0
            },
            completion: { (Bool) -> Void in
                UIView.animate(
                    withDuration: 1.0,
                    animations: { () -> Void in
                        if (self.inputGrades.count != 0) {
                            let gpa: Float = self.gpaCalculator.calculateGPA(self.inputGrades, self.inputCredits)
                            
                            self.gpaAmountLabel.text = "\(gpa)"
                        } else {
                            self.gpaAmountLabel.text = "N/A"
                        }
                        self.gpaAmountLabel.alpha = 1
                })
        })
    }
    
    func animateBackgroundColor() {
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: { () -> Void in
                self.view.backgroundColor = (UIColor.red)
            },
            completion: { (Bool) -> Void in
                UIView.animate(
                    withDuration: 2.0,
                    delay: 0,
                    options: [],
                    animations: { () -> Void in
                        self.view.backgroundColor = (UIColor.yellow)

            })
        })
    }
    
  /*  func animateGpaLabel() {
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: { () -> Void in
                self.gpaLabel.textColor = UIColor.red
                self.view.layoutIfNeeded()
            },
            completion: { (Bool) -> Void in
                UIView.animate(
                    withDuration: 2.0,
                    animations: { () -> Void in
                        self.gpaLabel.textColor = UIColor.black
                        self.gpaLabel.
                        self.view.layoutIfNeeded()
                })
        })
    }*/
    
    /*func animateCalculateLabel() {
        let width = view.frame.width
        
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: { () -> Void in
                
        })
    }*/
    
    @IBAction func resetGrades(sender: AnyObject) {
        inputGrades = [Float]()
        inputCredits = [Int]()
        encoder.inputCreditArray = [Int]()
        encoder.inputGradeArray = [Float]()
//        numInputGrades = 0
    }
    
    @IBAction func addGrade(sender: AnyObject) {
        if let currentInput = gpaCalculator.convertTextField(inputTextField) {
            if let creditInput = creditTextField.text {
                inputGrades.append(currentInput)
                inputCredits.append(Int(creditInput)!)
                
                encoder.inputCreditArray.append(Int(creditInput)!)
                encoder.inputGradeArray.append(currentInput)

            }
        }
        
        print(inputGrades)
    }
    
    @IBAction func calculateGrades(sender: AnyObject) {
    
//        animateCalculateButton()
        animateGpaAmountLabel()
        //animateGpaLabel()
        animateBackgroundColor()
        
       /* if (inputGrades.count != 0) {
            let gpa: Float = gpaCalculator.calculateGPA(inputGrades)
            
            gpaAmountLabel.text = "\(gpa)"
        }*/
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) { //the keyboard is dismissed if the user clicks out of either text field
        inputTextField.resignFirstResponder()
        creditTextField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myApp = UIApplication.shared
        
        let myDelegate = myApp.delegate as! AppDelegate
    
        encoder = myDelegate.encoder
        inputCredits = encoder.inputCreditArray
        inputGrades = encoder.inputGradeArray
      //  self.inputTextField.delegate = self
//        helpButton.alpha = 0
        view.backgroundColor = (UIColor.yellow)
        
        if(!(inputCredits.isEmpty) && !(inputGrades.isEmpty)) {
            let gpa: Float = self.gpaCalculator.calculateGPA(self.inputGrades, self.inputCredits)
            
            self.gpaAmountLabel.text = "\(gpa)"
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

