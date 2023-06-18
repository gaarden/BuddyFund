//
//  AppDelegate.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/04.
//
//
//import UIKit
//
//@UIApplicationMain
//final class AppDelegate: UIResponder, UIApplicationDelegate {
//
//}

import Foundation
import SwiftUI
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth
import UIKit



@main
struct Map_Watch_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // 나중에 각각의 유저세션을 인식하기 위해 환경변수로 세션 초기화 하고 넣어주는 과정 필요 ( NavigationView )
        WindowGroup {
//            Home().environmentObject(Present())
            MainTabView()
                .environmentObject(Present())
                .environmentObject(UserInfo(userid: "0cOa7C63F7uJHbAF7qcw")) // 사용자 아이디 수정 필요
                .environmentObject(ParticipateFundListViewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
                .environmentObject(CreateFundListVIewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
//                .environmentObject(ProductsViewModel(uid: "testid"))
            LoginView()
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // firebase 환경설정 추가
        FirebaseApp.configure()
        
        // Kakao 환경설정 추가
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        
        print("kakaoAppKey : \(kakaoAppKey)")
        
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }

        return false
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        
        sceneConfiguration.delegateClass = SceneDelegate.self
        
        return sceneConfiguration
    }

     
}
