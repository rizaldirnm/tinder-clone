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
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchAllUser(completion: @escaping([User]) -> Void) {
        var users = [User]()
        
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                if users.count == snapshot?.documents.count {
                    completion(users)
                }
            })
        }
    }
    
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
