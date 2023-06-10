
//
//  ProductDetailView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/13.
//

import SwiftUI
import Kingfisher

struct ProductDetailView: View {
    let product : Product
    var body: some View {
            descriptView
            .listStyle(.plain)
        }
}
private extension ProductDetailView{
    var productImage : some View{
//        KFImage(URL(string: self.product.itemImage))
//        .resizable()
//        .scaledToFill()
//        ResizedImage(self.product.itemImage)
        ShowImage(imageURL: product.itemImage)
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
                    Text("")
                        .padding([.bottom],85)
                }
                    .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2+40)
                    .edgesIgnoringSafeArea([.vertical])
                    .frame(height: g.size.height)
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
                FavoriteButton(product: product)

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
                Text("\(product.currentCollection)/\(product.price)")
            }
            ProgressBar(progress: (Double(product.currentCollection)/Double(product.price))*100)
                .frame(height:20)
            ZStack {
              NavigationLink(
                destination: {
                    ParticipateView(product: product).navigationBarBackButtonHidden()
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
}
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productSamples[0])
    }
}
