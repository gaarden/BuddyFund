//
//  Mypage.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/05/18.
//

import SwiftUI

struct Mypage: View {
    @State private var showingFundingItem: Bool = false
    @State private var showingCreateItem: Bool = false
    @EnvironmentObject var userInfo: UserInfo
    let user: User//preview를 위해 남겨놓음.
    
    var body: some View {
        NavigationView{
            VStack{
                ProfileBox(user: user)
                //ProfileBox(user: userInfo.user)
                    .scaleEffect(0.8)
                HStack{
                    Spacer()
                    Button(
                        action: {self.showingFundingItem.toggle()}
                    ){Text("참여한 펀딩")}
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width:130,height: 40)
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(6)
                        .sheet(isPresented: $showingFundingItem) {
//                            Text("ddd")
                            participateFundList
                        }
                    Button(
                        action: {self.showingCreateItem.toggle()}
                    ){Text("진행한 펀딩")}
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width:130,height: 40)
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(6)
                        .sheet(isPresented: $showingCreateItem) {
//                            Text("ddd")
                            myFundList
                        }
                    Spacer()
                }
//                List{
//                if showingFundingItem {
//                    participateFundList
////                    ParticipateFundListView(user: userInfo.user)
////                        .environmentObject(ParticipantsDetailViewModel(userid: userInfo.user.uid))
//                }
//                else {
//                    myFundList
//                }
                    //                Text("진행한 펀딩이 없습니다.")
                    //                FundingProduct(product: product)
                    //                FundingProduct(product: product)
//                }.listStyle(.plain)
                Spacer()
            }.padding()
                .navigationTitle("마이페이지")
                .navigationBarBackButtonHidden(true)
        }
    }
}
private extension Mypage {
    var participateFundList: some View{
        ParticipateFundListView(user: userInfo.user)
//            .environmentObject(ParticipantsDetailViewModel(userid: user.uid))
    }
    
    var myFundList : some View{
        MyFundListView()
//            .environmentObject(CreateFundListVIewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
    }
}

struct Mypage_Previews: PreviewProvider {
    static var previews: some View {
        Mypage(user: userSample)
            .environmentObject(UserInfo(userid: "0cOa7C63F7uJHbAF7qcw"))
            .environmentObject(ParticipateFundListViewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
        ProfileBox(user: userSample)
        
    }
}
