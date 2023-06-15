//  productViewModel로 바뀐 것 같음!!
//
//  Present.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/08.
//

import Foundation

final class Present : ObservableObject{
  @Published var products: [Product]
  
  // MARK: Initialization
  
  init(filename: String = "ProductData.json") {
      self.products = Bundle.main.decode(filename: filename, as: [Product].self)
  }
    
}
extension Present {
    func toggleFavorite(of product: Product){
        guard let index = products.firstIndex(of: product) else {
            return
        }
        products[index].isFavorite.toggle()
    }
}
