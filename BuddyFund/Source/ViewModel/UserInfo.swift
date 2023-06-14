//
//  UserInfo.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/10.
//

import Foundation
import Firebase

class UserInfo: ObservableObject {
    @Published var updateData = false
    @Published var user: User
//    @Published var friendsList: [String] = []
    @Published var favoriteProd: [String] = []
    
    init(userid: String) {
        print("DEBUG:: Get user data from DB")
        self.user = User(uid:"", username: "", profileImage: "", bday: "")
//        self.friendsList = pullFreinds(uid: userid)
        pullFavorites(uid: userid)
        fetchUser(uid: userid)
    }
    
    func pullFavorites(uid: String)->() {
        var favorites: [String] = []
        let UserRef = ProductsViewModel.db.collection("users").document(uid)
        
        UserRef.collection("favorites").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching favorites collection: \(error)")
                return
            }
            
            for document in snapshot?.documents ?? [] {
                let favoriteData = document.data()
                if let favoriteId = favoriteData["product"] as? String {
//                        print("friend: \(friendId)")
                    self.favoriteProd.append(favoriteId)
                } else {
                    print("no favorite")
                }
            }
        }
        
        print("favorites: \(favorites)")
//        return favorites
//        self.friendsList  = favorites
    }
    /*
    func pullFreinds(uid: String)->[String] {
        var friends : [String] = []
        let UserRef = ProductsViewModel.db.collection("users").document(uid)
        
        UserRef.collection("friends").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching friends collection: \(error)")
                return
            }
            
            for document in snapshot?.documents ?? [] {
                let friendData = document.data()
                if let friendId = friendData["product"] as? String {
//                        print("friend: \(friendId)")
                    friends.append(friendId)
                } else {
                    print("no favorite")
                }
            }
        }
        
        print("friends: \(friends)")
        return friends
    }
    */
    func fetchUser(uid: String) {
        let db = Firestore.firestore() // Firestore 인스턴스 생성
        
        let userRf = db.collection("users").document(uid)
        userRf.getDocument { (document, error) in
            if let error = error {
                print("Error fetching user document: \(error)")
                return
            } else if let document = document, document.exists {
                if let userData = document.data() {
                    let userid = uid
                    let username = userData["name"] as? String ?? ""
                    var profileImage = userData["profileUrl"] as? String ?? ""
                    
                    if profileImage == "" {
                        profileImage = "https://firebasestorage.googleapis.com/v0/b/buddyfund-fd57d.appspot.com/o/profiles%2Fdefault.png?alt=media&token=498cde06-7351-42b1-9ac3-da89004ea93c"
                    }
                    
                    let bday = userData["birthday"] as? String ?? ""
                    
                    self.user = User(uid: userid, username: username, profileImage: profileImage, bday: bday)
                }
                
            } else {
                print("Document dose not exit")
            }
        }
    }
}
