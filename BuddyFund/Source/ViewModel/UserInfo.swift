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
    
    init(userid: String) {
        print("DEBUG:: Get user data from DB")
        self.user = User(uid:"", username: "", profileImage: "", bday: "")
        fetchUser(userid: userid)
    }
    
    func fetchUser(userid: String) {
        let db = Firestore.firestore() // Firestore 인스턴스 생성
        
        db.collection("users").whereField("uid", isEqualTo: userid).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching user docaument: \(error)")
                return
            }
            
            guard let document = snapshot?.documents.first else { // userid에 해당하는 첫번째 데이터만 가져오기
                print("User document not found")
                return
            }
            
            let userData = document.data()
            
            let userid = document.documentID
            let username = userData["name"] as? String ?? ""
            let profileImage = userData["profileUrl"] as? String ?? ""
            let bday = userData["birthday"] as? String ?? ""
            
            self.user = User(uid: userid, username: username, profileImage: profileImage, bday: bday)
        }
    }
}
