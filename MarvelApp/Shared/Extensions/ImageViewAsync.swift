//
//  ImageViewAsync.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 21/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation
import UIKit

class ImageViewAsync: UIImageView {
    fileprivate var task: URLSessionDataTask?
}

extension ImageViewAsync {
    public func imageFromServerURL(urlString: String) {
        task?.cancel()
        guard let url = URL(string: urlString) else { return }
        self.task = URLSession.shared.dataTask(with: url , completionHandler: { (data, response, error) -> Void in
            guard error == nil else { return }
            DispatchQueue.main.async(execute: { () -> Void in
                guard let dataImage = data else { return }
                let image = UIImage(data: dataImage)
                self.image = image
            })
        })
        self.task?.resume()
    }
    
}
