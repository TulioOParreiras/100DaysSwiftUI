//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Usemobile on 28/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.errorHandler?(error)
        } else {
            self.successHandler?()
        }
    }
    
}
