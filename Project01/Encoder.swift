//
//  Encoder.swift
//  Project01
//
//  Created by Brooke Werner on 11/29/16.
//  Copyright © 2016 Brooke Werner. All rights reserved.
//

import UIKit

class Encoder: NSObject, NSCoding {
//    let aStringKey = "Caption"
    let inputGradesKey = "inputGradesArray"
    let inputCreditsKey = "inputCreditsArray"
    let aUniqueIDKey = "aUniqueID"
    let browserUrlKey = "URL"
    let photoUrlKey = "photoUrlKey"
    let imageSourceKey = "imageSourceKey"
    
    var inputGradeArray: [Float]
    var inputCreditArray: [Int]
//    var aString: String
    var aUniqueID: String
    var browserUrl: String
    var photoUrl: String
    var imageSource: String
    
    
    override init() {
        inputGradeArray = [Float]()
        inputCreditArray = [Int]()
//        aString = "default string"
        aUniqueID = NSUUID().uuidString
        browserUrl = ""
        photoUrl = ""
        imageSource = ""
    }
    
    required init(coder aDecoder: NSCoder) {
        inputCreditArray = aDecoder.decodeObject(forKey: inputCreditsKey) as! [Int]
        inputGradeArray = aDecoder.decodeObject(forKey: inputGradesKey) as! [Float]
        browserUrl = aDecoder.decodeObject(forKey: browserUrlKey) as! String
        aUniqueID = aDecoder.decodeObject(forKey: aUniqueIDKey) as! String
        photoUrl = aDecoder.decodeObject(forKey: photoUrlKey) as! String
        imageSource = aDecoder.decodeObject(forKey: imageSourceKey) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(inputGradeArray, forKey: inputGradesKey)
        aCoder.encode(inputCreditArray, forKey: inputCreditsKey)
//        aCoder.encode(aString, forKey: aStringKey)
        aCoder.encode(aUniqueID, forKey: aUniqueIDKey)
        aCoder.encode(browserUrl, forKey: browserUrlKey)
        aCoder.encode(photoUrl, forKey: photoUrlKey)
        aCoder.encode(imageSource, forKey: imageSourceKey)

    }
}
