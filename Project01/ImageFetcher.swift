//
//  ImageFetcher.swift
//  Project01
//
//  Created by Brooke Werner on 12/6/16.
//  Copyright © 2016 Brooke Werner. All rights reserved.
//

import UIKit

enum ImageFetchError: Error {
    case BadURL
    case ImageFetchFailed
    case NotImplementedYet
}

enum ImageFetchResult {
    case ImageSuccess(UIImage)
    case ImageFailure(Error)
}

class ImageFetcher {
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func fetchImage(url: String, completion: @escaping (ImageFetchResult) -> Void) {
        if let imageURL = URL(string: url) {
            let request = URLRequest(url: imageURL)
            
            let task = session.dataTask(with: request) {
                (data, response, error) -> Void in
                
                guard let imageData = data,
                    let image = UIImage(data: imageData) else {
                        if data == nil {
                            completion(.ImageFailure(error!))
                        }
                        else {
                            completion(.ImageFailure(ImageFetchError.ImageFetchFailed))
                        }
                        return
                }
                
                completion(.ImageSuccess(image))
            }
            task.resume()
        }
        else {
            
            
            completion(.ImageFailure(ImageFetchError.BadURL))
        }
    }
}
