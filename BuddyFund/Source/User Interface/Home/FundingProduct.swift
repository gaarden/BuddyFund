//
//  FundingProduct.swift
//  BuddyFund
//
//  Created by dahye on 2023/05/04.
//
import Foundation
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
          Text(calculateBirthdayDday(birthday: product.bday)) // product.~~ 형태로 수정 필요
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
    
    func calculateBirthdayDday(birthday: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        
        // 현재 날짜
        let currentDate = Date()
        var currentDateString = dateFormatter.string(from: currentDate)

        // 올해의 생일
        let currentYear = Calendar.current.component(.year, from: currentDate)
        let birthdayString = "\(currentYear)\(birthday)"

        // 생일이 지난 경우 내년 생일로 계산
        var nextBirthdayDateString = "\(currentYear)\(birthday)"
        dateFormatter.dateFormat = "YYYYMMdd"
        if let nextBirthdayDate = dateFormatter.date(from: nextBirthdayDateString){
            dateFormatter.dateFormat = "YYYYMMdd"
            currentDateString = dateFormatter.string(from: currentDate)
            nextBirthdayDateString = dateFormatter.string(from: nextBirthdayDate)

            if nextBirthdayDateString < currentDateString {
            nextBirthdayDateString = "\(currentYear + 1)\(birthday)"
        }
            else if nextBirthdayDateString == currentDateString {
                return "D-day"
            }
        }
        dateFormatter.dateFormat = "YYYYMMdd"
        // 날짜 계산
        let calendar = Calendar.current
        let birthdayDate = dateFormatter.date(from: nextBirthdayDateString)!
        let components = calendar.dateComponents([.day], from: currentDate, to: birthdayDate)
        dateFormatter.dateFormat = "YYYY"
        let c = nextBirthdayDateString.index(nextBirthdayDateString.startIndex,offsetBy: 3)
        if (Int(nextBirthdayDateString[nextBirthdayDateString.startIndex...c]) == currentYear)
        {
            let daysUntilBirthday = components.day!+1
            return("D-\(daysUntilBirthday)")
        }
        let daysUntilBirthday = components.day!
        
        return "D-\(daysUntilBirthday)"
    }
}

struct FundingProduct_Previews: PreviewProvider {
    static var previews: some View {
        FundingProduct(product: productSamples[0])
    }
}
