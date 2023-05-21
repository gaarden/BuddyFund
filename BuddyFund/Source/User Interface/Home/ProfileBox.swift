//
//  MypageBox.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/18.
//

import SwiftUI

struct ProfileBox: View {
    let product : Product
    var body: some View {
        VStack(spacing: 0){
            productImage
                .fixedSize()
            Rectangle()
                .fill(.gray)
                .opacity(0.1)
                .overlay(VStack{
                    Text(product.username).font(.title)
                        .fontWeight(.medium)
                        .padding([.vertical],1)
                    Text("\(product.username)님의 생일이 \(calculateBirthdayLeftDay(birthday: product.bday))")
                        .font(.title3)
                    fundDayButton(num:calculateBirthdayDdayInt(birthday: product.bday))
                })
        }.frame(width: 340,height: 400)
            .minimumScaleFactor(0.3)
    }
}
private extension ProfileBox{
    var productImage: some View {
        Image(product.profileImage)
            .resizable()
            .scaledToFill()
            .frame(width: 340,height: 250)
            .clipped()
    }
    func calculateBirthdayLeftDay(birthday: String) -> String {
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
                return "오늘입니다!"
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
            return("\(daysUntilBirthday)일 남았습니다!")
        }
        let daysUntilBirthday = components.day!
        
        return "\(daysUntilBirthday)일 남았습니다!"
    }
    func calculateBirthdayDdayInt(birthday: String) -> Int {
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
                return 0
                
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
            return daysUntilBirthday
        }
        let daysUntilBirthday = components.day!
        
        return daysUntilBirthday
        
    }
    func fundDayButton(num: Int)->some View {
        
        if num >= 15 && num <= 362 {
                return Button(
                    action: {}
                    ){Text("펀딩생성 D-\(num-14)")}
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width:310,height: 40)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(6)

            } else {
                return Button(
                    action: {print("버튼")}
                    ){Text("펀딩생성하기")}
                    .font(.headline)
                    .foregroundColor(.white)
                        .frame(width:310,height: 40)
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(6)

            }
        
    }
}
struct MypageBox_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBox(product: productSamples[0])
    }
}
