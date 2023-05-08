//
//  FundingProduct.swift
//  BuddyFund
//
//  Created by dahye on 2023/05/04.
//

import SwiftUI

struct FundingProduct: View {
    let product: Product
    
    var body: some View {
        VStack{
            HStack{
                profile.padding(5)
                Spacer()
                productDescription
                Spacer()
                productImage
            }.frame(height: 140)
                .padding([.horizontal, .top], 5)
            HStack{
                Spacer()
                progressView
                Spacer()
                Image(systemName:"star")
                Spacer()
            }.padding([.top, .bottom], 10)
        }.frame(height: 200)
        .background(Color.red.opacity(0.05))
        .background(Color.primary.colorInvert()) // 테두리에만 그림자하기 위한 것
        .cornerRadius(10)
        .shadow(color:Color.primary.opacity(0.33), radius: 1,x:2, y:2)
    }
}

private extension FundingProduct {
  // MARK: View
  
  var profile: some View {
      VStack{
          Image(product.profileImage)
              .resizable()
              .scaledToFill()
              .frame(width: 80,height:80)
              .clipShape(Circle())
          Text(product.username)
          Text("D-5") // product.~~ 형태로 수정 필요
              .font(.title2)
      }
  }
  
  var productDescription: some View {
      VStack(alignment: .leading){
          Text(product.title)
              .font(.title)
              .fontWeight(.bold)
          Spacer()
          Text(product.description)
              .font(.footnote)
              .foregroundColor(.secondary)
          Spacer()
      }.padding(5)
  }
  
    var productImage: some View {
        Image(product.itemImage)
            .resizable()
            .scaledToFill()
            .frame(width: 100)
            .clipped()
            .padding(5)
    }
    
    var progressView: some View {
        Rectangle()
            .frame(width:300, height: 10)
            .overlay(
                Rectangle()
                .fill(.green)
                .frame(width:200)
                .cornerRadius(6)
                     ,alignment:.leading)
            .cornerRadius(6)
//                ProgressBar()
//                Text("\(Int(progress))%")
    }
}

struct FundingProduct_Previews: PreviewProvider {
    static var previews: some View {
        FundingProduct(product: productSamples[0])
    }
}
