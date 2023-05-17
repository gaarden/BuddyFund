//
//  ParticipateView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/15.
//

import SwiftUI

struct ParticipateView: View {
    let product : Product
    @State var amount: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading){
                    Text(product.username+"님의 생일 : "+calculateBirthdayDday(birthday: product.bday))
                        .font(.title)
                        .padding([.vertical])
                    HStack{
                        Text("현재진행률")
                            .font(.title3)
                        Spacer()
                        Text("채워진 금액/\(product.price)")
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
                    TextField("펀딩할 금액을 입력하세요",text: $amount)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .frame(height: 50)
                        .background(Rectangle().stroke())
                        .padding([.vertical])
                    Text("입력된 금액 : "+stringNumberComma(number:amount))
                        .font(.title2)
                    Button(action: {
                        if stringNumberComma(number: amount) != "" {
                            self.showingAlert.toggle()
                        }
                    }) {
                        Capsule()
                            .stroke(Color.black)
                            .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 50)
                            .overlay(Text("펀딩하기")
                                .font(.system(size: 20)).fontWeight(.medium)
                                .foregroundColor(Color.black))
                            .padding(.vertical, 8)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("금액 확인"), message: Text("\(product.username)님께 \(stringNumberComma(number:amount))원을 펀딩하시겠습니까?"), primaryButton: .cancel(Text("취소")), secondaryButton: .default(Text("펀딩하기"), action: {}))
                    }
                }
                .padding()
                Spacer()
            }.navigationTitle(product.title)
        }
    }
}
private extension ParticipateView {
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
    func stringNumberComma(number: String)->String{
        let temp = Int(number)
        var tempString = ""
        var result = ""
        if let convertedNumber = temp {
            if convertedNumber<0 {
                return "0보다 큰 값을 입력하세요."
            }
            tempString = String(convertedNumber)
            var index = tempString.startIndex
            var sIndex = tempString.index(tempString.startIndex,offsetBy: 0)
            var eIndex = tempString.index(tempString.startIndex,offsetBy: 1)
            for i in 0..<tempString.count{
                result += tempString[sIndex..<eIndex]
                if ((tempString.count-1-i) % 3 == 0)&&(tempString.count-1 != i){
                    result+=","
                }
                sIndex = eIndex
                eIndex = tempString.index(sIndex,offsetBy: 1,limitedBy: tempString.endIndex) ?? sIndex
            }
        }
        return result
    }
}

struct ParticipateView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipateView(product: productSamples[0])
    }
}
