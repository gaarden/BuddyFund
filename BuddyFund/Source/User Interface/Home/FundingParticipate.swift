//
//  FundingParticipate.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/06/15.
//

import SwiftUI

struct FundingParticipate: View {
    let product: Product
    
    var body: some View {
        VStack{
            HStack{
                profile.padding(5)
                Spacer()
                productDescription
                Spacer()
                productImage
            }.frame(height: 100)
                .padding([.horizontal, .top], 3)
                .padding([.bottom], 20)
            Text("(날짜): (User 닉네임)님이 (얼마) 펀딩하셨습니다.")
                .bold()
        }.frame(height: 190)
        .background(Color.red.opacity(0.05))
        .background(Color.primary.colorInvert()) // 테두리에만 그림자하기 위한 것
        .cornerRadius(10)
        .shadow(color:Color.primary.opacity(0.33), radius: 1,x:2, y:2)
    }
}

private extension FundingParticipate {
  // MARK: View
    
  var profile: some View {
      VStack{
//          Image(product.profileImage)
//          KFImage(URL(string: product.profileImage))
//              .resizable()
//              .scaledToFill()
//          ResizedImage(product.profileImage)
          ShowImage(imageURL: product.profileImage)
              .frame(width: 80,height:80)
              .clipShape(Circle())
          Text(product.username)
      }
  }
  
  var productDescription: some View {
      VStack(alignment: .leading){
          Text(product.title)
              .font(.title2)
              .frame(maxWidth: 200, maxHeight: 100, alignment: .leading)
              .fontWeight(.bold)
              .minimumScaleFactor(0.3)
          Spacer()
          Text(product.description)
              .font(.footnote)
              .foregroundColor(.secondary)
      }.padding(5)
  }
  
    var productImage: some View {
//        KFImage(URL(string: product.itemImage))
//            .resizable()
//            .scaledToFill()
//        ResizedImage(product.itemImage)
        ShowImage(imageURL: product.itemImage)
            .frame(width: 100,height:133)
            .clipped()
            .padding(5)
    }
}

struct FundingParticipate_Previews: PreviewProvider {
    static var previews: some View {
        FundingParticipate(product: productSamples[1])
    }
}
