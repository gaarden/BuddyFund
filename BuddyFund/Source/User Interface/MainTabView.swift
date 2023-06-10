//
//  MainTabView.swift
//  BuddyFund
//
//  Created by 정다혜 on 2023/06/05.
//

import SwiftUI

struct MainTabView: View {
    private enum Tabs{
        case home, myPage
    }
    @State private var selectedTab: Tabs = .home
    @State private var userId = "testid" // 사용자 로그인 아이디 정보
    @EnvironmentObject var userinfo: UserInfo
    
    var body: some View {
        TabView(selection: $selectedTab){
            Group{
                home
                myPage
            }.accentColor(.primary)
        }
        .accentColor(.black)
        .edgesIgnoringSafeArea(.top)
    }
}
fileprivate extension View{
    func tabItem(image: String, text: String)-> some View{
        self.tabItem{
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(nil)
                .font(Font.system(size: 17, weight: .light))
            Text(text)
        }
    }
}
private extension MainTabView{
    var home: some View{
        Home()
            .tag(Tabs.home)
            .tabItem(image: "gift", text: "진행중인 펀딩")
    }
    var myPage: some View{
        Mypage(user: userinfo.user)
            .tag(Tabs.myPage)
            .tabItem(image: "person", text: "마이페이지")
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
//            .environmentObject(Present())
            .environmentObject(UserInfo(userid: "testid"))
            .environmentObject(ProductsViewModel(uid: "testid"))
    }
}
