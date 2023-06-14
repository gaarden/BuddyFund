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
        fetchUser(uid: userid)
    }
    
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
            
//            guard let document = snapshot?.documents.first else { // userid에 해당하는 첫번째 데이터만 가져오기
//                print("User document not found")
//                return
//            }
//
//            let userData = document.data()
//
//            let userid = document.documentID
//            let username = userData["name"] as? String ?? ""
//            let profileImage = userData["profileUrl"] as? String ?? ""
//            let bday = userData["birthday"] as? String ?? ""
//
//            self.user = User(uid: userid, username: username, profileImage: profileImage, bday: bday)
        }
    }
}
