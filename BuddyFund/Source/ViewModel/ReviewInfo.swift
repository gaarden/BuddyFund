//
//  ReviewInfo.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/11.
//

import Foundation
import Firebase

class ReviewInfo: ObservableObject {
    @Published var updateData = false
    @Published var reviews = [Review]()
    let pid: String
    
    init(pid: String) {
        print("DEBUG:: Get product's review data from DB")
        self.pid = pid
        fetchReivews(product: pid)
    }
    
    func convertTimestampToStr(timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dateFomatter.string(from: date)
        
        return dateStr
    }
    
    func fetchReivews(product: String) { // product 의 펀딩에 참여한 리스트
        let db = Firestore.firestore()
        
        db.collection("products").document(product).collection("participants").order(by: "date", descending: true).getDocuments {snapshot, error in
            if let error = error {
                print("Error fetching user docaument: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("User document not found")
                return
            }
            
            self.reviews.removeAll()
            
            for document in documents {
                let reviewData = document.data()
                
                let uid = reviewData["user"] as? String ?? ""
                
                let username = reviewData["nickname"] as? String ?? ""
                let comment = reviewData["comment"] as? String ?? ""
                let date = reviewData["date"] as? Timestamp ?? Timestamp()
                let commentDate = self.convertTimestampToStr(timestamp: date)
                let funding = reviewData["funding"] as? Int ?? 0
                let participantId = reviewData["user"] as? String ?? ""
                let review = Review(username: username, comment: comment, commentDate: commentDate, funding: funding, uid: participantId)
                self.reviews.append(review)
            }
        }
    }
}
