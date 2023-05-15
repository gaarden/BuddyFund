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
          Text("D"+days(from: product.bday)) // product.~~ 형태로 수정 필요
              .font(.title2)
      }
  }
  
  var productDescription: some View {
      VStack(alignment: .leading){
          Text(product.title)
              .font(.title2)
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
    func days(from dateStr: String) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        var daysCount:Int = 0
        let components1 = calendar.dateComponents([.year, .month, .day], from: currentDate)
        var components = DateComponents()
        components.day = components1.day
        components.month = components1.month
        let startDate = calendar.date(from: components)
        let c = dateStr.index(dateStr.startIndex,offsetBy: 2)
        var endIndex = dateStr.index(dateStr.startIndex,offsetBy: 1)
        components.month = Int(dateStr[dateStr.startIndex...endIndex])
        endIndex = dateStr.index(c,offsetBy: 1)
        components.day = Int(dateStr[c...endIndex])
        let specialDay = calendar.date(from: components)
        
        daysCount = calendar.dateComponents([.day], from: specialDay ?? Date(), to: startDate!).day!
        daysCount *= -1
        if daysCount<0
        {
            return String(daysCount)
        }
        else if daysCount==0
        {
            return "-day"
        }
        else// if daysCount<4
        {
            return "-"+String(daysCount)
            //이거 +가 아니라 -가 되어야하는거 아니야??
        }
        //날짜 처리해야함.
    }
}

struct FundingProduct_Previews: PreviewProvider {
    static var previews: some View {
        FundingProduct(product: productSamples[0])
    }
}
