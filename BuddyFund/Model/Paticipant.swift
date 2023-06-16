//
//  Paticipant.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/16.
//

import Foundation

struct Participate {
    let id : UUID = UUID()
    let product: Product
    let nickname: String
    let funding: Int
    let date: String
}

extension Participate: Decodable {}
extension Participate: Identifiable {}
extension Participate: Equatable {}

let participantSamples = [
    Participate(product: productSamples[0], nickname : "홍길순", funding: 2000, date: "2023-05-15 00:49:18" ),
    Participate(product: productSamples[1], nickname : "익명1", funding: 2000, date: "2023-05-16 00:49:18" )
]
