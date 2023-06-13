//
//  ParticipateFundingViewModel.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/14.
//

import Foundation
import Firebase

class ParticipateFundingViewModel: ObservableObject {
    @Published var didUpload = false
//    var product: Product
//
//    init(product: Product) {
//        self.product = product
//    }
    
    func participateFunding(product: Product, user: String, nickname: String, funding: Int, comment: String) {
        
        //        guard let uid = Auth.auth().currentUser?.uid else {return}
        let uid = "testid"
        
        let fundingdata: [String: Any] = [
            "user": user,
            "nickname": nickname,
            "funding": funding,
            "date": Timestamp(date: Date()),
            "comment": comment
        ]
        
        // 펀딩 데이터 참여 데이터 추가
        let refData = Firestore.firestore().collection("products").document(product.pid).collection("participants").document()
        refData.setData(fundingdata) {error in
            if let error = error {
                print("Error adding participate funding document: \(error)")
            } else {
                print("Success add participate funding to FIrestore")
            }
        }
        
        // 펀딩의 현재 모음 금액 업데이트
        let newFund = product.currentCollection + funding
        Firestore.firestore().collection("products").document(product.pid).updateData(["currentFund": newFund])
        
        
        // 사용자의 참여 펀딩 목록에 데이터 추가
        let fundinglistdata = [
            "participantsId": refData.documentID,
            "productId": product.pid
        ]
        Firestore.firestore().collection("users").whereField("uid", isEqualTo: uid).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching user docaument: \(error)")
                return
            }
            guard let document = snapshot?.documents.first else { // userid에 해당하는 첫번째 데이터만 가져오기
                print("User document not found")
                return
            }
            let userId = document.documentID
            Firestore.firestore().collection("users").document(userId).collection("participateFundings").document().setData(fundinglistdata)
        }
    }
}
