//
//  EncoderPersister.swift
//  Project01
//
//  Created by Brooke Werner on 11/29/16.
//  Copyright © 2016 Brooke Werner. All rights reserved.
//

import UIKit

class EncoderPersister: NSObject {
    static let encoderArchiveURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask)
        
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent("encoder.archive") as NSURL
    }()
    
    class func setEncoder(_ encoder: Encoder) -> Bool {
        return NSKeyedArchiver.archiveRootObject(encoder, toFile: encoderArchiveURL.path!)
    }
    
    class func getEncoder() -> Encoder {
        if let encoder = NSKeyedUnarchiver.unarchiveObject(withFile: encoderArchiveURL.path!) as? Encoder {
            return encoder
        } else {
            return Encoder()
        }
    }
}
