//
//  ContentView.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/04.
//

import SwiftUI

struct Home: View {
//    @EnvironmentObject private var present : Present
    @EnvironmentObject private var productsInfo : ProductsViewModel
    @EnvironmentObject private var user: UserInfo
    
    var body: some View {
        var orderproducts = productsInfo.products.sorted{calculateBirthdayDday(birthday: $0.bday) < calculateBirthdayDday(birthday: $1.bday)}
        isfavoriteProc(products: &orderproducts, isfavorites: user.favoriteProd)
        print(orderproducts)
        return NavigationView {
            List(orderproducts){ product in // DB 연결
//            List(present.products){ product in
                ZStack {
                  NavigationLink(
                    destination: {
                        ProductDetailView(product: product)
                            .environmentObject(ReviewInfo(pid: product.pid))
                    },     
                    label: {
                      EmptyView()
                        }
                    )
                    .opacity(0)
                    HStack {
                        FundingProduct(product: product)
                    }
                    
                }.listRowSeparator(.hidden)
//                .listRowBackground((Color.indigo).opacity(0.2))
              }
              .listStyle(PlainListStyle())
              .navigationTitle("진행중인 펀딩")
            }
    }
    
    func calculateBirthdayDday(birthday: String) -> Int {
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
    
    func isfavoriteProc(products: inout [Product], isfavorites:[String]) {
        for index in products.indices {
            if isfavorites.contains(products[index].pid) {
                products[index].isFavorite = true
                let item = products.remove(at: index)
                products.insert(item, at: 0)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source:Home())
//            .environmentObject(Present())
            .environmentObject(ProductsViewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
            .environmentObject(UserInfo(userid: "0cOa7C63F7uJHbAF7qcw"))
//            .environmentObject(ParticipateFundingViewModel())
    }
}
