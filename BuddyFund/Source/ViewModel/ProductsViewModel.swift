//
//  ProductsViewModel.swift
//  BuddyFund
//
//  Created by minyeong on 2023/05/23.
//

import Foundation
import Firebase

class ProductsViewModel: ObservableObject {
    @Published var updateData = false
    @Published var products = [Product]()
    @Published var friendsList: [String] = []
    static let db = Firestore.firestore()
    let uid: String
    
    init(uid: String) {
        print("DEBUG:: Get product data from DB")
        self.uid = uid
        fetchProducts(uid: uid)
    }
    
    func fetchProducts(uid: String) { // 친구 목록 가져오기
        
        ProductsViewModel.db.collection("users").whereField("uid", isEqualTo: uid).getDocuments {snapshot, error in
            if let error = error {
                print("Error fetching user docaument: \(error)")
                return
            }
            
            guard let document = snapshot?.documents.first else { // userid에 해당하는 첫번째 데이터만 가져오기
                print("User document not found")
                return
            }
            
            let userId = document.documentID
//            print("user Id: \(userId)")
            
            let friendsCollectionRef = ProductsViewModel.db.collection("users").document(userId).collection("friends")
            
            friendsCollectionRef.getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching friends collection: \(error)")
                    return
                }
                
                for document in snapshot?.documents ?? [] {
                    let friendData = document.data()
                    if let friendId = friendData["user"] as? String {
//                        print("friend: \(friendId)")
                        self.friendsList.append(friendId)
                    } else {
                        print("no friends")
                    }
                }
                
                if self.friendsList.isEmpty {
                    print("friendsList Empty")
                } else {
                    print(self.friendsList) // 쿼리 완료 이후에 friendsList 출력
                    
                    ProductsViewModel.db.collection("products").whereField("writerId", in: self.friendsList).getDocuments { snapshot, error in
                        if let error = error {
                            print("Error fetching documents: \(error)")
                            return
                        }
//
                        guard let documents = snapshot?.documents else {
                            print("No documents found")
                            return
                        }
//
                        self.products.removeAll()
                        
                        for document in documents {
                            let pid = document.documentID
                            let data = document.data()
        //                    print(data)
                            let title = data["title"] as? String ?? ""
                            let itemImage = data["itemUrl"] as? String ?? ""
                            let description = data["description"] as? String ?? ""
                            let price = data["price"] as? Int ?? 0
                            let currentCollection = data["currentFund"] as? Int ?? 0
                            let isFavorite = data["isFavortie"] as? Bool ?? false //별도 수정 필요
                            let account = data["account"] as? String ?? ""
                            
                            // 펀딩 생성자 정보 가져오기
                            if let writerRef = data["writerId"] as? String {
                                ProductsViewModel.db.collection("users").document(writerRef).getDocument { userSnapshot, userError in
                                    if let userError = userError {
                                        print("Error fetching referenced document: \(userError)")
                                    } else {
                                        if let userData = userSnapshot?.data() {
        //                                    print(userData)
                                            let username = userData["name"] as? String ?? ""
                                            let profileImage = userData["profileUrl"] as? String ?? ""
                                            let bday = userData["birthday"] as? String ?? ""
                                            
                                            let product = Product(pid:pid, title: title, username: username, profileImage: profileImage, itemImage: itemImage, bday: bday, description: description, price: price, currentCollection: currentCollection, isFavorite: isFavorite, account: account)
                                            
                                            self.products.append(product)
                                            
                                        }
                                        else {
                                            print("Nope")
                                        }
                                    }
                                }
                            } else {
                                print("Failed to cast writerId field to String")
                            }
                                
                        }
                    }
                }
            }
        }
    }
}
