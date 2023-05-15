//
//  ParticipateView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/15.
//

import SwiftUI

struct ParticipateView: View {
    let product : Product
    
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading){
                    Text(product.username+"님의 생일 : D"+days(from: product.bday))
                        .font(.title)
                        .padding([.vertical])
                    HStack{
                        Text("현재진행률")
                            .font(.title3)
                        Spacer()
                        Text("채워진 금액/목표 금액")
                            .font(.title3)
                    }.padding([.vertical])
                    Rectangle()
                        .frame(height: 10)
                        .overlay(
                            Rectangle()
                                .fill(.green)
                                .frame(width:200)
                                .cornerRadius(6)
                            ,alignment:.leading)
                        .cornerRadius(6)
                    Text("펀딩할 금액을 입력하세요.")
                        .font(.title3)
                        .padding(.vertical)
                    Rectangle()
                        .stroke(Color.gray)
                        .frame(height: 50)
                        .overlay(Text("텍스트 박스 들어갈 위치"))
                    Button(action: {
                        //펀딩창으로 연결
                    }) {
                        Capsule()
                            .stroke(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 50)
                            .overlay(Text("펀딩하기")
                                .font(.system(size: 20)).fontWeight(.medium)
                                .foregroundColor(Color.black))
                            .padding(.vertical, 8)
                    }
                }
                .padding()
                Spacer()
            }.navigationTitle(product.title)
        }
    }
}
private extension ParticipateView {
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

struct ParticipateView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipateView(product: productSamples[0])
    }
}
