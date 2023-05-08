//
//  Product.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/08.
//

import Foundation

struct Product {
    let id: UUID = UUID()
    var title: String // 수정할 수 있으니까
    let username: String
    let profileImage: String
    var itemImage: String // 수정할 수 있으니까
    let bday: String
    var description: String // 수정할 수 있으니까
    let price: Int
    var isFavorite: Bool = false
}

extension Product: Decodable {}
extension Product: Identifiable {}


let productSamples = [
    Product(title : "다혜펀딩제목", username : "정다혜", profileImage : "user1", itemImage : "slamdunk", bday : "1203", description : "펀딩설명나는다혜", price: 200),
    Product(title : "정원펀딩제목", username : "문정원", profileImage : "user2", itemImage : "applewatch", bday : "1111", description : "펀딩설명나는정원", price: 300),
]
