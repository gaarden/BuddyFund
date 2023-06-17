//
//  CreateFundViewModel.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/18.
//

import Foundation
import Firebase
import UIKit
import FirebaseStorage

class CreateFundViewModel: ObservableObject {
    
    
    func createFund(user: User, account:String, description: String, price: Int, title: String, img: UIImage) { //itemUrl: ""
        var imageUrl = ""
        
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let filePath = "products/\(user.uid)_\(title)_\(price).jpg"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let productsRef = storageRef.child(filePath)
        
        productsRef.putData(data, metadata: metaData) { metaData, error in
            if let error = error {
                print("Upload image fail:: \(error)")
            } else {
                productsRef.downloadURL { url, error in
                    if let error = error {
                        print("Get URL Error:: \(error)")
                    } else if let url = url {
                        imageUrl = url.absoluteString
                        
                        let fundingdata: [String: Any] = [
                            "account": account,
                            "currentFund": 0,
                            "date": Timestamp(date: Date()),
                            "description": description,
                            "itemUrl": imageUrl,
                            "price": price,
                            "title": title,
                            "writerId": user.uid
                        ]
                        
                        // 펀딩 생성 데이터 추가
                        let refData = Firestore.firestore().collection("products").document()
                        refData.setData(fundingdata) {error in
                            if let error = error {
                                print("Error adding participate funding document: \(error)")
                            } else {
                                print("Success add participate funding to FIrestore")
                            }
                        }
                        
                        let userRef = Firestore.firestore().collection("users").document(user.uid)
                        userRef.updateData(["createFundings": FieldValue.arrayUnion([refData.documentID])])
                    }
                }
                print("Success")
            }
            
        }
        
        
        
    }
}
