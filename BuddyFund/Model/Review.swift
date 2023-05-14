//
//  Review.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/15.
//

import Foundation

struct Review {
    let id : UUID = UUID()
//    let productId: UUID : 값 입력도 UUID 전달받아서 되게 해야함.
    let username: String
    var comment: String // 수정할 수 있으니까
    var commentDate : String
}

extension Review: Decodable {}
extension Review: Identifiable {}


let reviewSamples = [
    Review(username : "홍길동", comment: "생일축하해 담에 나 만날때 끼고와라><",commentDate: "2023-05-15 00:50:22"),
    Review(username : "홍길순", comment: "생일축하해🤩",commentDate: "2023-05-15 00:49:18")
]
