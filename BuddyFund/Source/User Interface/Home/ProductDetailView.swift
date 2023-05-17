
//
//  ProductDetailView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/13.
//

import SwiftUI

struct ProductDetailView: View {
    let product : Product
    var body: some View {
            descriptView
            .listStyle(.plain)
            .edgesIgnoringSafeArea(.all)
        }
}
private extension ProductDetailView{
    var productImage : some View{
        Image(self.product.itemImage)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
    }
    var descriptView : some View {
        GeometryReader{ g in
            NavigationView{
                
                List{
                    productImage
                    self.productDescription
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(reviewSamples, id: \.self) { review in
                            reviewBox(review: review)
                        }
                    }
                }.frame(width:400)
            }
            
        }
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
    
    var productDescription : some View {
        VStack(alignment: .leading, spacing: 16){
            HStack{
                Text(product.title)
                    .font(.largeTitle).fontWeight(.medium)
                    .frame(width:320, height: 60, alignment: .leading)
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.3)
                
                Spacer()
                Image(systemName: "star")
                    .imageScale(.large)
                    .foregroundColor(Color.blue)
                    .frame(width:32, height: 32)
            }
            Text(product.username+"님의 생일 "+calculateBirthdayDday(birthday: product.bday))
            Text(product.description)
                .fixedSize(horizontal: false, vertical: true)
                    .frame(minWidth: 350, maxWidth: 400, minHeight: 20, maxHeight: 160, alignment: .leading)
                .foregroundColor(.secondary)
                .padding(.vertical)
            Text(product.account)
            HStack{
                Text("현재진행률")
                Spacer()
                Text("채워진 금액/\(product.price)")
            }
            Rectangle()
                .frame(height: 10)
                .overlay(
                    Rectangle()
                        .fill(.green)
                        .frame(width:200)
                        .cornerRadius(6)
                    ,alignment:.leading)
                .cornerRadius(6)
            ZStack {
              NavigationLink(
                destination: {
                    ParticipateView(product: product)
                },
                label: {
                  EmptyView()
                }
              )
              .opacity(0)
              
              HStack {
                  Capsule()
                            .stroke(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                            .overlay(Text("펀딩하기")
                                .font(.system(size: 20)).fontWeight(.medium)
                                .foregroundColor(Color.black))
                            .padding(.vertical, 8)
                    
              }
            }
            
            Text("참여내역")
            HStack{
                Spacer()
                Text("총 "+"변수"+"명이 참여하였습니다.")
                Spacer()
            }
        }
    }
    
    func stringNumberSpace(text: String)->String{
        var tempString = text
        var result = ""
        var sIndex = tempString.index(tempString.startIndex,offsetBy: 0)
        var eIndex = tempString.index(tempString.startIndex,offsetBy: 25)
        for i in 0..<tempString.count{
            result += tempString[sIndex..<eIndex]
            if ((tempString.count-1-i) % 25 == 0){
                result+="\n"
            }
            sIndex = eIndex
            eIndex = tempString.index(sIndex,offsetBy: 1,limitedBy: tempString.endIndex) ?? sIndex
        }
        result += tempString[sIndex..<tempString.endIndex]
        
        return result
    }
}
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productSamples[0])
    }
}
