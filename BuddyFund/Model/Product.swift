//
//  Product.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/08.
//

import Foundation

struct Product {
    let id : UUID = UUID()
    var title: String // 수정할 수 있으니까
    let username: String
    let profileImage: String
    var itemImage: String // 수정할 수 있으니까
    let bday: String
    var description: String // 수정할 수 있으니까
    let price: Int
    var isFavorite: Bool = false
    var account : String
}

extension Product: Decodable {}
extension Product: Identifiable {}


let productSamples = [ //이제 이곳에는 굳이 추가하지 않아도 됨. json에 추가하면 됨.
    Product(title : "다혜펀딩제목", username : "정다혜", profileImage : "user1", itemImage : "slamdunk", bday : "0518", description : "펀딩설명나는다혜", price: 200, account: "카카오 3333-00-0000-000"),
    Product(title : "정원펀딩제목", username : "문정원", profileImage : "user2", itemImage : "applewatch", bday : "1111", description : "펀딩설명나는정원", price: 300, account: "카카오 3333-00-0000-000"),
]
