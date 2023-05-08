//
//  Present.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/08.
//

import Foundation

final class Present {
  var products: [Product]
  
  // MARK: Initialization
  
  init(filename: String = "ProductData.json") {
      self.products = Bundle.main.decode(filename: filename, as: [Product].self)
  }
}
