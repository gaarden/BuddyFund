//
//  CreateFundListVIewModel.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/17.
//

import Foundation
import Firebase

class CreateFundListVIewModel: ObservableObject {
    @Published var creates:[String] = []
    @Published var createsFund = [Product]()
    @Published var favoriteProd: [String] = []
    
    init(uid:String) {
        fetchCreatesList(uid: uid)
    }
    
    func fetchCreatesList(uid: String) {
        let db = Firestore.firestore()
        
        let userRf = db.collection("users").document(uid)
        userRf.getDocument { (document, error) in
            if let error = error {
                print("Error fetching user document: \(error)")
                return
            } else if let document = document, document.exists {
                if let userData = document.data() {
                    let userid = uid
                    self.creates = userData["createFundings"] as? [String] ?? []
                    self.favoriteProd = userData["favorites"] as? [String] ?? [] // 즐겨찾기 목록
                    
                    for doc in self.creates {
                        let productsRef = ProductsViewModel.db.collection("products").document(doc)
                        productsRef.getDocument { snapshot, pError in
                            if let pError = pError {
                                print("Error fetching documents: \(pError)")
                                return
                            } else if let snapshot = snapshot, snapshot.exists {
                                let pid = snapshot.documentID
                                if let productData = snapshot.data() {
                                    let title = productData["title"] as? String ?? ""
                                    let itemImage = productData["itemUrl"] as? String ?? ""
                                    let description = productData["description"] as? String ?? ""
                                    let price = productData["price"] as? Int ?? 0
                                    let currentCollection = productData["currentFund"] as? Int ?? 0
                                    let isFavorite = self.favoriteProd.contains(pid) //별도 수정 필요
                                    let account = productData["account"] as? String ?? ""
                                    
                                    // 펀딩 생성자 정보 가져오기
                                    if let writerRef = productData["writerId"] as? String {
                                        let createrId = writerRef
                                        ProductsViewModel.db.collection("users").document(writerRef).getDocument { userSnapshot, userError in
                                            if let userError = userError {
                                                print("Error fetching referenced document: \(userError)")
                                            } else {
                                                if let userData = userSnapshot?.data() {
                    //                                    print(userData)
                                                    let username = userData["name"] as? String ?? ""
                                                    var profileImage = userData["profileUrl"] as? String ?? ""
                                                    
                                                    // 프로필 없으면 기본 이미지 가져오기
                                                    if profileImage == "" {
                                                        profileImage = "https://firebasestorage.googleapis.com/v0/b/buddyfund-fd57d.appspot.com/o/profiles%2Fdefault.png?alt=media&token=498cde06-7351-42b1-9ac3-da89004ea93c"
                                                    }
                                                    
                                                    let bday = userData["birthday"] as? String ?? ""
                                                    
                                                    let product = Product(pid:pid, title: title, username: username, profileImage: profileImage, itemImage: itemImage, bday: bday, description: description, price: price, currentCollection: currentCollection, isFavorite: isFavorite, account: account, createrId: createrId)
                                                    
                                                    self.createsFund.append(product)
        //                                            print("friends: \(self.friendsList)")
        //                                            print("favorites: \(self.favoriteProd)")
        //                                            print("products: \(self.products)")
                                                    
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
                            } else {
                                print("NONE")
                            }
                        }
                    }
                }
                
            } else {
                print("Document dose not exit")
            }
        }
    }
}
