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
        VStack(spacing : 0){
            productImage
            descriptView
        }
        .edgesIgnoringSafeArea([.top,.bottom])
    }
}
private extension ProductDetailView{
    var productImage : some View{
        Image(self.product.itemImage)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
    var descriptView : some View {
        List{
            self.productDescription
            reviewBox
            reviewBox
        }.listStyle(.plain)
//        .edgesIgnoringSafeArea([.bottom])
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2),radius: 10, x:0, y:-5)
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
            return "+"+String(daysCount)
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
            Button(action: {
                //펀딩창으로 연결
            }) {
                Capsule()
                    .stroke(Color.black)
                    .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                    .overlay(Text("펀딩하기")
                        .font(.system(size: 20)).fontWeight(.medium)
                        .foregroundColor(Color.black))
                    .padding(.vertical, 8)
            }
            Text("참여내역")
            Text("총"+"변수"+"명이 참여하였습니다.")//.frame(alignment: .leading)위의 vstack leading때문에 가운데 정렬 안됨
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
    
    var reviewBox: some View {
        VStack {
            HStack {
                Text("홍길순")
                    .font(.title3)
                Spacer()
                Text("\(getDate())")
            }
            HStack {
                Text("생일축하해🤩")
                Spacer()
            }
        }
    }
    
    func getDate() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: now)
        
        return dateString
    }
}
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productSamples[1])
    }
}
