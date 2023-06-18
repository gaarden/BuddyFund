//
//  FundingProgress.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/06/15.
//

import SwiftUI

struct FundingProgress: View {
    let product: Product
    let onprogress = true
    
    var body: some View {
            VStack{
                HStack{
                    VStack {
                        HStack {
                            sticker.padding([.leading, .top])
                            Spacer()
                        }
                        productDescription
                            .padding([.leading])
                    }
                    productImage
                }
                if (!onprogress) {
                    
                } else {
                    ProgressBar(progress: 50)
                        .padding([.horizontal])
                }
            }.frame(height: 190)
            .background(Color.red.opacity(0.05))
            .background(Color.primary.colorInvert()) // 테두리에만 그림자하기 위한 것
            .cornerRadius(10)
            .shadow(color:Color.primary.opacity(0.33), radius: 1,x:2, y:2)
    }
}

private extension FundingProgress {
  // MARK: View

  var productDescription: some View {
      VStack(alignment: .leading){
          Text(product.title)
              .font(.title2)
              .frame(maxHeight: 50, alignment: .leading)
              .fontWeight(.bold)
          Spacer()
          Text(product.description)
              .font(.footnote)
              .frame(maxHeight: 200)
              .foregroundColor(.secondary)
          Spacer()
          Spacer()
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
    
    var sticker: some View {
        // 진행중이면 진행중 스티커, 종료면 종료 스티커
        Text(onprogress ? "진행중" : "종료")
            .frame(width: 50)
            .padding([.all], 3)
            .background(onprogress ? Color.yellow.opacity(0.5) : Color.gray.opacity(0.5))
            .cornerRadius(8)
    }

}

struct FundingProgress_Previews: PreviewProvider {
    static var previews: some View {
        FundingProgress(product: productSamples[1])
    }
}
