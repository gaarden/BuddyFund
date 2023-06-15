//
//  FavoriteButton.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/31.
//

import SwiftUI

struct FavoriteButton: View {
//    @EnvironmentObject private var present: Present
    @EnvironmentObject private var present: ProductsViewModel
    let product: Product
    
    private var imageName: String {
        product.isFavorite ? "star.fill" : "star"
    }
    
    var body: some View {
        Image(systemName: imageName)
            .imageScale(.large)
            .foregroundColor(.yellow)
            .frame(width: 32, height: 32)
            .onTapGesture {
                self.present.toggleFavorite(of: self.product)
            }
    }
}
struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            FavoriteButton(product: productSamples[0])
            FavoriteButton(product: productSamples[2])
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
