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
    var currentCollection: Double
    var isFavorite: Bool = false
    var account : String
}

extension Product: Decodable {}
extension Product: Identifiable {}


let productSamples = [ //이제 이곳에는 굳이 추가하지 않아도 됨. json에 추가하면 됨.
    Product(title : "슬덩만화책을 사도될까요", username : "정다혜", profileImage : "user1", itemImage : "slamdunk", bday : "0518", description : "반갑습니다 사장님들 저는 정다혜라고 합니다. 제가 이번에 정말 감명깊게 본 영화가 무엇이냐. 그것은 바로 슬램덩크입니다. 그거 아시나요? 사실 슬램덩크는 영화보다 만화책이 10배 더 재밌다는 것을요 호호 정말 사고싶은데 너무 비싸요 ㅜㅜ 여러분들 감사합니다!", price: 166500, currentCollection: 0.0, account: "카카오 3333-00-0000-000"),
    Product(title : "애플워치 원해요! 원해요!", username : "문정원", profileImage : "user2", itemImage : "applewatch", bday : "1111", description : "펀딩설명나는정원", price: 300, currentCollection: 90.0, account: "카카오 3333-00-0000-000"),
    Product(title: "백호는 농구대가 필요하다..", username: "강백호", profileImage: "user3", itemImage: "basketballhoop", bday: "0401", description: "강백호입니다. 농구연습을 하려고 하는데 농구대가 없어서 못하고 있습니다. 나중에 큰 사람돼서 기억하겠습니다. 감사합니다 뿅", price: 1680000, currentCollection: 0.0, account: "카카오 3333-00-0000-000")
]
