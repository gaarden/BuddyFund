
//
//  ProductDetailView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/13.
//

import SwiftUI
import Kingfisher
import Firebase

struct ProductDetailView: View {
    @EnvironmentObject private var reviewInfo : ReviewInfo
    @EnvironmentObject var userinfo: UserInfo
    @State var showFundDesct = false
//    @State private var isNavigationBarHidden = false
    
    var product : Product
    var body: some View {
        var reviews = reviewInfo.reviews.sorted{ $0.commentDate < $1.commentDate
        }
        NavigationView{
            descriptView
        }
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
        return GeometryReader{ g in
            ScrollView{
                    productImage
                    self.productDescription
                    ForEach(0..<1){index in
                        NavigationLink(
                            destination: ParticipateView(product: product)
                                .navigationBarBackButtonHidden(true)
                                .environmentObject(ParticipateFundingViewModel()),
                            label: {
                                Capsule()
                                    .stroke(Color.black)
                                    .frame(maxWidth: .infinity, minHeight: 35, maxHeight: 55)
                                    .overlay(Text("펀딩하기")
                                        .font(.system(size: 20))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.black))
                                    .padding(.horizontal,13)
                                    .padding(.vertical,5)
                            }
                        )
                    }
                    fundinglist
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(reviewInfo.reviews, id: \.self) { review in
                            reviewBox(review: review).padding(.horizontal,13)
                        }
                    }
                    Text("")
                        .padding([.bottom],85)
                }
                .position(x: g.size.width/2, y: g.size.height/2+38)
                .edgesIgnoringSafeArea([.bottom])
                .frame(height: g.size.height)
//                                    .navigationBarHidden(true)
            }
//        .navigationTitle("")
           
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
            
        }.padding(.horizontal,18)
    }
    var fundingbutton : some View {
        ForEach(0..<1){index in
            ZStack {
                NavigationLink(
                    destination: {
                        ParticipateView(product: product)
                                            .navigationBarBackButtonHidden()
                            .environmentObject(ParticipateFundingViewModel())
                    },
                    label: {
                        EmptyView()
                    }
                )
                .opacity(0)
                
                Capsule()
                    .stroke(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 35, maxHeight: 55)
                    .overlay(Text("펀딩하기")
                        .font(.system(size: 20)).fontWeight(.medium)
                        .foregroundColor(Color.black))
                    .padding(.vertical, 8)
            }
        }
    }
    
    var fundinglist: some View {
        HStack{
            VStack(alignment: .center) {
                Text("참여내역")
                    .fontWeight(.bold)
                    .font(.headline)
                    
                Text("총 \(reviewInfo.reviews.count)명이 참여하였습니다.")
                // 사용자가 생성한 펀딩의 경우 참여 내역 상세보기 가능
                if userinfo.user.uid == product.createrId {
    //            if true {
                fundinglistDetail.frame(height:40)
                }
            }.frame(width: UIScreen.main.bounds.width)
            .padding(10)
            
        }
    }
    
    var fundinglistDetail: some View {
        Button {
            showFundDesct.toggle()
        } label: {
            Rectangle()
                .fill(.indigo)
                .opacity(0.9)
                .frame(maxWidth: 150, maxHeight: 40)
                .cornerRadius(30)
                .overlay(Text("참여내역 상세보기")
                    .font(.subheadline)
                    .foregroundColor(.white)
                             )
        }
        .sheet(isPresented: $showFundDesct) {
            ParticipateDescriptionView()
        }

//        ZStack {
//            Rectangle()
//                .fill(.indigo)
//                .frame(maxWidth: 130, maxHeight: 30)
//                .cornerRadius(30)
//            Text("참여내역 상세보기")
//                .font(.footnote)
//                .foregroundColor(.white)
//            NavigationLink(destination: ParticipateDescriptionView(showFundDesct: $showFundDesct)) {
//                EmptyView()
//            }
//            .opacity(0)
//        }
    }
    
}


struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productSamples[0])
            .environmentObject(ReviewInfo(pid: "RK0jXlcAcvM0EUQf93Hj"))
            .environmentObject(UserInfo(userid: "0cOa7C63F7uJHbAF7qcw"))
    }
}
