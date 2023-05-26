//
//  ProductsViewModel.swift
//  BuddyFund
//
//  Created by minyeong on 2023/05/23.
//

import Foundation
import Firebase

class ProductsViewModel: ObservableObject {
    @Published var products = [Product]()
    
    init() {
        print("DEBUG:: Get product data from DB")
        fetchProducts()
    }
    
    func fetchProducts() {
        
        let db = Firestore.firestore() // Firestore 인스턴스 생성
        
        db.collection("products").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                // 기존 배열을 비워주고 Firebase에서 가져온 데이터로 배열 채우기
                self.products.removeAll()
//                print(documents)
                
                for document in documents {
                    let data = document.data()
                    
                    // Firebase에서 가져온 데이터로 Product 객체 생성
                    if let userId = data["ownerUid"] as? String {
                        // products 에서 fetch
                        let title = data["title"] as? String ?? ""
                        let itemImage = data["itemUrl"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let price = data["price"] as? Int ?? 0
                        let currentCollection = data["currentCollection"] as? Int ?? 0
                        let account = data["account"] as? String ?? ""
                        
                        // 해당 펀딩 생성자 정보를 가져오기 위해 "users" 컬렉션 접근
                        db.collection("users").document(userId).getDocument { (userDocument, userError) in
                            if let userDocument = userDocument, userDocument.exists {
                                let userData = userDocument.data()
                                
                                if let username = userData?["name"] as? String,
                                   let profileImage = userData?["profileUrl"] as? String,
                                   let bday = userData?["birthday"] as? String {
                                    let product = Product(title: title, username: username, profileImage: profileImage, itemImage: itemImage, bday: bday, description: description, price: price, currentCollection: currentCollection, account: account)
                                    self.products.append(product)
                                    print("product list: \(product)")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
