//
//  User.swift
//  BuddyFund
//
//  Created by minyeong on 2023/06/10.
//

import Foundation

struct User {
    let id : UUID = UUID()
    let uid : String
    let username: String
    let profileImage: String
    let bday: String
}


extension User: Decodable {}
extension User: Identifiable {}
extension User: Equatable {}

let userSample = User(uid: "sample1", username: "강백호", profileImage: "user3", bday: "0401")
