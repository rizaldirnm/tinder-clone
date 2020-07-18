//
//  Service.swift
//  TinderClone
//
//  Created by Rizaldi Nur Muhammad on 18/07/20.
//  Copyright © 2020 Rizaldi. All rights reserved.
//

import UIKit
import Firebase

struct Service {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "images/\(filename)")
        print("uploading...")
        ref.putData(imageData, metadata: nil) { (metaData, error) in
            if let error = error {
                print("DEBUG: ERROR uploading image \(error.localizedDescription)")
                return
            }
            print("upload success...")
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}
