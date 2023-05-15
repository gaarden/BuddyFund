
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
        NavigationView{
            
            List{
                productImage
                self.productDescription
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(reviewSamples, id: \.self) { review in
                        reviewBox(review: review)
                    }
                }
            }
        }
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
    
    var productDescription : some View {
        VStack(alignment: .leading, spacing: 16){
            Spacer()
            HStack{
                Text(product.title)
                    .font(.largeTitle).fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "star")
                    .imageScale(.large)
                    .foregroundColor(Color.blue)
                    .frame(width:32, height: 32)
            }
            Text(product.username+"님의 생일이 D"+days(from: product.bday))
            Text(splitText(product.description))
                .foregroundColor(.secondary)//color extension을 안해서 secondary extension이 아님
                .fixedSize()
            Text(product.account)
            HStack{
                Text("현재진행률")
                Spacer()
                Text("채워진 금액/목표 금액")
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
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productSamples[1])
    }
}
