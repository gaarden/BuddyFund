//
//  ParticipateView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/15.
//

import SwiftUI
import Firebase

struct ParticipateView: View {
    var product : Product
    @State var notice : String = ""
    @State var amount: String = ""
    @State private var showingAlert = false
    @State private var showingPopup = false
    @State private var showNotice = false
    @State private var nickname = ""
    @State var message: String = ""
    @EnvironmentObject var userinfo: UserInfo
    @EnvironmentObject var viewModel: ParticipateFundingViewModel
    @EnvironmentObject var productsInfo: ProductsViewModel
    @EnvironmentObject var participates: ParticipateFundListViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                Text(product.title).font(.largeTitle).bold().frame(height:140,alignment:.bottom)
                Text(product.username+"님의 생일 : "+calculateBirthdayDday(birthday: product.bday))
                    .font(.title)
                    .padding([.vertical])
                
                progressBar
                
                fundingExp
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.indigo)
                    .padding(.bottom, 15)
                
                nicknameField
                    .padding(.bottom)
                
                messageField
                    
                fundingCancelButton
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 85)
//            .navigationTitle(product.title)
            .edgesIgnoringSafeArea([.vertical])
//            .popup(isPresented: $showingPopup){
//                Text("✦ 펀딩완료 ✧")
//                .font(.system(size:24))
//                .bold()
//                .multilineTextAlignment(.center)
//            }
        }

    }
    
    var progressBar: some View {
        VStack {
            HStack{
                Text("현재진행률")
                    .font(.title3)
                Spacer()
                Text("\(product.currentCollection)/\(product.price)")
                    .font(.title3)
            }.padding([.vertical])
            ProgressBar(progress: (Double(product.currentCollection)/Double(product.price))*100)
                .frame(height: 20)
        }
    }

    var fundingExp: some View {
        VStack(alignment: .leading) {
            TextField("펀딩할 금액을 입력하세요",text: $amount)
                .multilineTextAlignment(.center)
                .font(.title)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 6).stroke())
            if showNotice {
                Text("금액을 확인해 주세요.")
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.bottom, 2)
            }
            Text("입력된 금액 : "+stringNumberComma(number:amount))
                .font(.title2)
        }
        .padding(.bottom, 15)
    }
    
    var fundingCancelButton: some View {
        HStack {
            Button(action: {
//                if stringNumberComma(number: amount) != "_" {
                    stringNumberComma(number: amount)
                    self.showingAlert.toggle()
//                }
            }) {
                Capsule()
                    .fill(Color.indigo).opacity(0.4)
                    .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 50)
                    .overlay(Text("펀딩하기")
                        .font(.system(size: 20)).fontWeight(.medium)
                        .foregroundColor(Color.black))
                    .padding(.vertical, 8)
            }
            .buttonStyle(ShrinkButtonStyle())
            .alert(isPresented: $showingAlert) {
                if showNotice {
                    //
                    return Alert(title: Text("금액 확인"),
                                 message: Text("\(notice)"))
                } else {
                    return Alert(title: Text("금액 확인"),
                                 message: Text("\(product.username)님께 \(stringNumberComma(number:amount))원을 펀딩하시겠습니까?\n펀딩메세지:\(message)"),
                                 primaryButton: .default(
                                   Text("펀딩하기"),
                                   action: {
                                       saveFundingDB()
                                   }),
                                 secondaryButton: .cancel(Text("취소")))
                }
                
                
            }
             
            // 취소버튼
            Button(action: {
                print("Cancle Funding")
            }) {
                NavigationLink(destination: ProductDetailView(product: product).navigationBarBackButtonHidden())
                {
                    Capsule()
                        .fill(Color.gray).opacity(0.4)
                        .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 50)
                        .overlay(Text("취소하기")
                        .font(.system(size: 20)).fontWeight(.medium)
                        .foregroundColor(Color.black))
                        .padding(.vertical, 8)
                }
            }.buttonStyle(ShrinkButtonStyle())
        }
    }
    
    var nicknameField: some View {
        VStack(alignment: .leading) {
            Text("닉네임")
            TextField("  \(userinfo.user.username)",text: $nickname)
                .multilineTextAlignment(.leading)
                .frame(height: 30)
                .background(RoundedRectangle(cornerRadius: 6).stroke())
            Text("별도로 입력하지 않으면 사용자 이름으로 나타납니다.")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    var messageField: some View {
        VStack(alignment: .leading) {
            Text("메세지")
            TextEditor(text: $message)
                .font(Font.title3)
                .frame(height: 150)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke())
                .overlay(
                    Text("생일 축하 메세지를 남겨주세요~!")
                        .padding(8)
                        .foregroundColor(.gray)
                        .opacity(message.isEmpty ? 0.7 : 0), alignment: .topLeading
                    )
                .padding(.bottom, 5)
        }
    }
    
    private func saveFundingDB() {
            // 펀딩 금액 입력이 숫자인지 확인
            if let funding = Int(amount) {
                if funding > product.price - product.currentCollection {
                    // 펀딩 금액이 남은 금액을 초과할 경우 처리
                    print("Funding Error: Exceed the price")
                } else if funding < 0 {
                    print("Funding Error: The price is Minus")
                } else {
                    // 펀딩 금액이 적절한 경우
                    if nickname == "" {
                        nickname = userinfo.user.username
                    }
                    
                    viewModel.participateFunding(uid:userinfo.user.uid, product: product, nickname: nickname, funding: funding, comment: message)
                    
                    showingPopup.toggle()
                    
//                    viewModel.didUpload.toggle()
                    
//                    participates.didupdate.toggle()
                    userinfo.updateData.toggle()
                    
                    print("DEBUG:: \(product.currentCollection) && update: \(viewModel.didUpload)")
                    
                }
            } else {
                // 펀딩 금액이 올바른 형식이 아닌 경우
                print("Not correct Funding data type")
            }
        }
    
    func stringNumberComma(number: String)->String{
        let temp = Int(number)
        var tempString = ""
        var result = ""
        if let convertedNumber = temp {
            if convertedNumber<0 {
                showNotice = true
                notice = "0보다 큰 값을 입력하세요."
                return "_"
            }
            tempString = String(convertedNumber)
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
            
            if convertedNumber + product.currentCollection > product.price {
                showNotice = true
                notice = "펀딩 가능한 금액을 초과했습니다."
            } else if convertedNumber + product.currentCollection == product.price {
                showNotice = false
                notice = "펀딩 금액을 모두 채웠습니다!"
            } else {
                showNotice = false
                notice = ""
            }
            return result
        } else {
            showNotice = true
            notice = "올바른 형식으로 입력하세요"
            return "_"
        }
//        return result
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

struct ParticipateView_Previews: PreviewProvider {
    static var previews: some View {
        ParticipateView(product: productSamples[0])
            .environmentObject(UserInfo(userid: "0cOa7C63F7uJHbAF7qcw"))
            .environmentObject(ParticipateFundingViewModel())
            .environmentObject(ProductsViewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
    }
}
