//
//  Mypage.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/18.
//

import SwiftUI

struct Mypage: View {
    let product : Product
    @State private var showingFundingItem:
    Bool = true
    
    
    var body: some View {
        NavigationView{
            VStack{
                ProfileBox(product: product)
                    .scaleEffect(0.8)
                HStack{
                    Button(
                        action: {self.showingFundingItem = true}
                    ){Text("참여한 펀딩")}
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width:130,height: 40)
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(6)
                    Button(
                        action: {self.showingFundingItem = false}
                    ){Text("진행한 펀딩")}
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width:130,height: 40)
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(6)
                    Spacer()
                }
                List{
                    if showingFundingItem {
                        participateFundList
                    }
                    else {
                        myFundList
                    }
                    //                Text("진행한 펀딩이 없습니다.")
                    //                FundingProduct(product: product)
                    //                FundingProduct(product: product)
                }.listStyle(.plain)
                Spacer()
            }.padding()
                .navigationTitle("마이페이지")

        }
    }
}
private extension Mypage {
    var participateFundList: some View{
        ParticipateFundListView()
        
    }
    var myFundList : some View{
        MyFundListView()
    }
}

struct Mypage_Previews: PreviewProvider {
    static var previews: some View {
        Mypage(product: productSamples[2])
        ProfileBox(product: productSamples[1])
        
    }
}
