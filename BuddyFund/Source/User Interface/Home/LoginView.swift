//
//  LoginView.swift
//  BuddyFund
//
//  Created by 민시온 on 2023/05/23.
//

import SwiftUI
import KakaoSDKAuth

struct LoginView: View {
    
    @StateObject var kakaoAuth: KakaoAuth = KakaoAuth()
    
    let loginStatus : (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 상태" : "로그아웃 상태"
    }
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text(loginStatus(kakaoAuth.isLoggedIn))
            
            Button("카카오 로그인") {
                kakaoAuth.kakaoLogin()
            }
            .frame(width: 280, height: 60)
            .border(.black, width: 1)
            
            Button("카카오 로그아웃") {
                kakaoAuth.kakaoLogout()
            }
            .frame(width: 280, height: 60)
            .border(.black, width: 1)
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
