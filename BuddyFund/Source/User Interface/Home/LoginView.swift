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
            Spacer()
            Text("BuddyFund")
                .font(.title)
                .bold()
            Image(systemName: "gift.fill")
                .resizable()
                .imageScale(.large)
                .foregroundColor(Color.gray)
                .frame(width:64, height: 64)

            Text(loginStatus(kakaoAuth.isLoggedIn))
            Spacer()
            
            HStack {
                Spacer()
                Button("카카오계정으로 로그인하기") {
                    kakaoAuth.kakaoLogin()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.indigo)
                .cornerRadius(8)
                Spacer()
            }
            
            HStack {
                Spacer()
                Button("카카오 로그아웃") {
                    kakaoAuth.kakaoLogout()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.indigo)
                .cornerRadius(8)
                Spacer()
            }
            
            HStack {
                Spacer()
                Button("카카오계정으로 회원가입하기") {
                    //
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.indigo)
                .cornerRadius(8)
                Spacer()
            }
            
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

