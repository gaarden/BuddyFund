//
//  ParticipateFundListViewModel.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/16.
//

import Foundation
import Firebase

class ParticipateFundListViewModel: ObservableObject {
//    var testId: [String] = []
    var participateList = [Participate]()
//    var products = [Product]()
//    var reviews = [Review]()
//    var friendsList: [String] = []
    var favoriteProd: [String] = []
//    var participates: [String] = []
    
    init(uid: String) {
//        fetchParticipateFundList(uid: uid)
        test2(uid: uid)
//        self.testId = ["test", "test2"]
    }
    
    func convertTimestampToStr(timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dateFomatter.string(from: date)
        
        return dateStr
    }
    
    func test1(uid: String) {
        let UserRef = Firestore.firestore().collection("users").document(uid)
        
        UserRef.collection("participateFundings").getDocuments { snapshot, error in
            if let error = error {
                print("Error: \(error)")
            }
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            //            self.products.removeAll()
            
            for document in documents {
                let data = document.data()
                let rid = data["participantsId"] as? String ?? ""
                let pid = data["productId"] as? String ?? ""
                
//                self.testId.append(rid)
            }
        }
    }
    
    /*
    func test4(uid: String) {
        
        let db = Firestore.firestore() // Firestore 인스턴스 생성
        
        let UserRef = db.collection("users").document(uid)
//        userRf.getDocument { (document, error) in
//            if let error = error {
//                print("Error fetching user document: \(error)")
//                return
//            } else if let document = document, document.exists {
//                if let userData = document.data() {
//                    let userid = uid
//                    let username = userData["name"] as? String ?? ""
//                    var profileImage = userData["profileUrl"] as? String ?? ""
//
//                    if profileImage == "" {
//                        profileImage = "https://firebasestorage.googleapis.com/v0/b/buddyfund-fd57d.appspot.com/o/profiles%2Fdefault.png?alt=media&token=498cde06-7351-42b1-9ac3-da89004ea93c"
//                    }
//
//                    let bday = userData["birthday"] as? String ?? ""
//
//                    self.testId.append(username)
//
////                    self.user = User(uid: userid, username: username, profileImage: profileImage, bday: bday)
//                }
//
//            } else {
//                print("Document dose not exit")
//            }
//        }
    
        
        UserRef.collection("participateFundings").getDocuments { snapshot, error in
            if let error = error {
                print("Error: \(error)")
            }
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }

            //            self.products.removeAll()

            for document in documents {
                if let error = error {
                    print("Error: \(error)")
                }
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }

                //            self.products.removeAll()

                for document in documents {
                    let data = document.data()
                    let rid = data["participantsId"] as? String ?? ""
                    let pid = data["productId"] as? String ?? ""
                    let nickname = data["nickname"] as? String ?? ""
                    let funding = data["funding"] as? Int ?? 0
                    let date = "2023-05-16 00:49:18"

                    let participate = Participate(product: productSamples[0], nickname: nickname, funding: funding, date: date)
                    self.participateList.append(participate)
                    self.testId.append(nickname)
                }
            }
        }
    }
    */
    /*
    func test3(uid: String) {
        let UserRef = Firestore.firestore().collection("users").document(uid)
        
        UserRef.getDocument { snapshot, error in
            if let error = error {
                print("Error: \(error)")
            } else if let snapshot = snapshot, snapshot.exists {
                if let userData = snapshot.data() {
                    self.favoriteProd = userData["favorites"] as? [String] ?? []
                    self.participates = userData["participates"] as? [String] ?? []
                    
                    for productDc in self.participates {
                        let productRef = Firestore.firestore().collection("products").document(productDc)
                        productRef.collection("participants").whereField("user", isEqualTo: uid).getDocuments { proSnap, proError in
                            if let proError = proError {
                                print("Error: \(proError)")
                            }
                            
                            guard let documents = proSnap?.documents else {
                                print("No documents found")
                                return
                            }
                            
                            for document in documents {
                                let participateData = document.data()
                                
                                let nickname = participateData["nickname"] as? String ?? ""
                                let funding = participateData["funding"] as? Int ?? 0
                                let date = "2023-05-16 00:49:18"
                                
                                let participate = Participate(product: productSamples[0], nickname: nickname, funding: funding, date: date)
                                self.participateList.append(participate)
                            }
                            
                        }
                    }
                }
            } else {
                print("None")
            }
        }
        
        
    }

    */
    func test2(uid: String) {
        let UserRef = Firestore.firestore().collection("users").document(uid)
        
        UserRef.getDocument { snapshot, error in
            if let error = error {
                print("Error: \(error)")
            } else if let snapshot = snapshot, snapshot.exists {
                if let userData = snapshot.data() {
                    self.favoriteProd = userData["favorites"] as? [String] ?? []
                }
            } else {
                print("None")
            }
        }
        
        UserRef.collection("participateFundings").getDocuments { snapshot, error in
            if let error = error {
                print("Error: \(error)")
            }
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            //            self.products.removeAll()
            
            for document in documents {
                let data = document.data()
                let rid = data["participantsId"] as? String ?? ""
                let pid = data["productId"] as? String ?? ""
                let nickname = data["nickname"] as? String ?? ""
                let funding = data["funding"] as? Int ?? 0
                let date = data["date"] as? Timestamp ?? Timestamp()
                let commentDate = self.convertTimestampToStr(timestamp: date)
                
                if let prodRef = data["ref"] as? DocumentReference {
                    prodRef.getDocument { productSnap, productError in
                        if let productError = productError {
                            print("Error: \(productError)")
                        } else if let productSnap = productSnap, productSnap.exists {
                            if let productdata = productSnap.data() {
                                let title = productdata["title"] as? String ?? ""
                                let itemImage = productdata["itemUrl"] as? String ?? ""
                                let description = productdata["description"] as? String ?? ""
                                let price = productdata["price"] as? Int ?? 0
                                let currentCollection = productdata["currentFund"] as? Int ?? 0
                                let isFavorite = self.favoriteProd.contains(pid) //별도 수정 필요
                                let account = productdata["account"] as? String ?? ""

                                // 펀딩 생성자 정보 가져오기
                                if let writerRef = productdata["writerId"] as? String {
                                    let createrId = writerRef
                                    
                                    let writerRef = Firestore.firestore().collection("users").document(writerRef)
                                    writerRef.getDocument { userSnapshot, userError in
                                        if let userError = userError {
                                            print("Error fetching referenced document: \(userError)")
                                        } else if let userSnapshot = userSnapshot, userSnapshot.exists {
                                            if let writerData = userSnapshot.data() {
                                                let writer = writerData["name"] as? String ?? ""
                                                var profileImage = writerData["profileUrl"] as? String ?? ""
                                                
                                                // 프로필 없으면 기본 이미지 가져오기
                                                if profileImage == "" {
                                                    profileImage = "https://firebasestorage.googleapis.com/v0/b/buddyfund-fd57d.appspot.com/o/profiles%2Fdefault.png?alt=media&token=498cde06-7351-42b1-9ac3-da89004ea93c"
                                                }
                                                
                                                let bday = writerData["birthday"] as? String ?? ""
                                                
                                                let product = Product(pid:pid, title: title, username: writer, profileImage: profileImage, itemImage: itemImage, bday: bday, description: description, price: price, currentCollection: currentCollection, isFavorite: isFavorite, account: account, createrId: createrId)
                                                
    //                                            self.products.append(product)
                                                
                                                let participate = Participate(product: product, nickname: nickname, funding: funding, date: commentDate)
                                                self.participateList.append(participate)
                                            }
                                        } else {
                                            print("None")
                                        }
                                    }
                                }

                            }
                        } else {
                            print("NONE")
                        }
                    }
                }
                
                
                // Product 정보 가져오기
                
            }
        }
    }
     

}
