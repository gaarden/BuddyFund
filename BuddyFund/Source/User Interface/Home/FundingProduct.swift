//
//  FundingProduct.swift
//  BuddyFund
//
//  Created by dahye on 2023/05/04.
//
import Foundation
import SwiftUI
import Kingfisher

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
                ProgressBar(progress: (Double(product.currentCollection)/Double(product.price))*100)
                Spacer()
                FavoriteButton(product: product)
                Spacer()
            }
        }.frame(height: 190)
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
//          Image(product.profileImage)
//          KFImage(URL(string: product.profileImage))
//              .resizable()
//              .scaledToFill()
//          ResizedImage(product.profileImage)
          ShowImage(imageURL: product.profileImage)
              .frame(width: 80,height:80)
              .clipShape(Circle())
          Text(product.username)
          Text(calculateBirthdayDday(birthday: product.bday))
              .font(.title2)
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
    
    func calculateBirthdayDday(birthday: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        
        // 현재 날짜
        let currentDate = Date()
        var currentDateString = dateFormatter.string(from: currentDate)

        // 올해의 생일
        let currentYear = Calendar.current.component(.year, from: currentDate)
        
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
    func splitText(_ text: String) -> String {
        guard !text.isEmpty else { return text }
        let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
        let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ") ?? text[centerIdx...].firstIndex(of: " ") ?? text.index(before: text.endIndex)
        let afterSpaceIdx = text.index(after: centerSpaceIdx)
        let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
        let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)
        return String(lhsString + "\n" + rhsString)
    }
}

struct FundingProduct_Previews: PreviewProvider {
    static var previews: some View {
        FundingProduct(product: productSamples[1]).padding()
    }
}
