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
    @Published var didupdate = false
    @Published var participateList = [Participate]()
//    var products = [Product]()
//    var reviews = [Review]()
//    var friendsList: [String] = []
    @Published var favoriteProd: [String] = []
    @Published var participates: [String] = []
//    let uid: String
    
    
    init(uid: String) {
        fetchParticipateFundList(uid: uid)
    }
    
    func convertTimestampToStr(timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dateFomatter.string(from: date)
        
        return dateStr
    }
    
    func fetchParticipateFundList(uid: String) {
        let userRef = Firestore.firestore().collection("users").document(uid)
        
        userRef.getDocument { userSnapshot, userError in
            if let userError = userError {
                print("Error: \(userError)")
            } else if let userSnapshot = userSnapshot, userSnapshot.exists {
                if let userData = userSnapshot.data() {
                    self.favoriteProd = userData["favorites"] as? [String] ?? [] // 즐겨찾기 목록
                }
            } else {
                print("None")
            }
        }
        
        let ref = Firestore.firestore().collection("participates")
        
        ref.whereField("user", isEqualTo: uid).getDocuments { snapshot, error in
            if let error = error {
                print("Error: \(error)")
            }
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.participateList.removeAll()
            
            for document in documents {
                let data = document.data()
                
                let pid = data["pid"] as? String ?? ""
                let nickname = data["nickname"] as? String ?? ""
                let funding = data["funding"] as? Int ?? 0
                let date = data["date"] as? Timestamp ?? Timestamp()
                let commentDate = self.convertTimestampToStr(timestamp: date)
                
                let pref = Firestore.firestore().collection("products").document(pid)
                pref.getDocument { psnapshot, perror in
                    if let perror = perror {
                        print("Error: \(perror)")
                    } else if let psnapshot = psnapshot, psnapshot.exists {
                        if let pdata = psnapshot.data() {
                            let title = pdata["title"] as? String ?? ""
                            let itemImage = pdata["itemUrl"] as? String ?? ""
                            let description = pdata["description"] as? String ?? ""
                            let price = pdata["price"] as? Int ?? 0
                            let currentCollection = pdata["currentFund"] as? Int ?? 0
                            let isFavorite = self.favoriteProd.contains(pid)
                            let account = pdata["account"] as? String ?? ""
                            let writerId = pdata["writerId"] as? String ?? ""
                            
                            let writerRef = Firestore.firestore().collection("users").document(writerId)
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
                                        
                                        let product = Product(pid:pid, title: title, username: writer, profileImage: profileImage, itemImage: itemImage, bday: bday, description: description, price: price, currentCollection: currentCollection, isFavorite: isFavorite, account: account, createrId: writerId)
                                        
//                                            self.products.append(product)
                                        
                                        let participate = Participate(product: product, nickname: nickname, funding: funding, date: commentDate)
                                        self.participateList.append(participate)
                                    }
                                } else {
                                    print("None")
                                }
                            }
                        }
                    } else {
                        print("None")
                    }
                }
            }
        }
    }
}
