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
    
    func participateFunding(uid:String, product: Product, user: String, nickname: String, funding: Int, comment: String) {
        
        //        guard let uid = Auth.auth().currentUser?.uid else {return}
        let uid = uid // 현재 로그인한 사용자 doc id
        
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
        Firestore.firestore().collection("users").document(uid).collection("participateFundings").document().setData(fundinglistdata)
    }
}
