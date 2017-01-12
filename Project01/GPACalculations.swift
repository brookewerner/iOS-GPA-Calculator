//
//  GPACalculations.swift
//  Project01
//
//  Created by Brooke Werner on 11/5/16.
//  Copyright © 2016 Brooke Werner. All rights reserved.
//

import UIKit

class GPACalculations {
    
    func convertTextField(_ inputTextField: UITextField) -> Float! {
        if let input = inputTextField.text {
            if (input == "A") {
                return 4.0
            } else if (input == "A-") {
                return 3.7
            } else if (input == "B+") {
                return 3.3
            } else if (input == "B") {
                return 3.0
            } else if (input == "B-") {
                return 2.7
            } else if (input == "C+") {
                return 2.3
            } else if (input == "C") {
                return 2.0
            } else if (input == "C-") {
                return 1.7
            } else if (input == "D+") {
                return 1.3
            } else if (input == "D") {
                return 1.0
            } else if (input == "D-") {
                return 0.7
            } else if (input == "F" || input == "E") {
                return 0.0
            } else {
                print("error - not a valid grade input")
            }
        } else {
            print("error - not a valid grade input")
        }
        
        return nil
    }

    func calculateGPA(_ inputGrades: [Float], _ inputCredits: [Int]) -> Float {
        var sumPointsEarned: Float = 0
        var numCreditsEarned: Float = 0
        var index: Int = 0
        var pointsAtIndex: Float = 0
        var creditsAtIndex: Float = 0
        
        for _ in inputCredits {
            pointsAtIndex = inputGrades[index]
            creditsAtIndex = (Float)(inputCredits[index])
            
            sumPointsEarned = sumPointsEarned + (pointsAtIndex * creditsAtIndex)
            numCreditsEarned = numCreditsEarned + creditsAtIndex
            
            index = index + 1
        }
        
        return sumPointsEarned/numCreditsEarned
    }
}
