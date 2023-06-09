//
//  SceneDelegate.swift
//  BuddyFund
//
//  Created by Jeongwon Moon on 2023/05/04.
//

import SwiftUI
import KakaoSDKAuth
import Foundation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
//      let rootView = Home(present: Present())
      let rootView = MainTabView()
          .environmentObject(Present())
          .environmentObject(UserInfo(userid: "0cOa7C63F7uJHbAF7qcw")) // 사용자 아이디 수정 필요
          .environmentObject(ProductsViewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
          .environmentObject(ParticipateFundListViewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
          .environmentObject(CreateFundListVIewModel(uid: "0cOa7C63F7uJHbAF7qcw"))
//      let rootView = LoginView()
      
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: rootView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
    
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.handleOpenUrl(url: url)
        }
    }
}
}


