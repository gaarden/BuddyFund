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

import SwiftUI
import FirebaseCore

@main
struct Map_Watch_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        // 나중에 각각의 유저세션을 인식하기 위해 환경변수로 세션 초기화 하고 넣어주는 과정 필요 ( NavigationView )
        WindowGroup {
            Home(present: Present())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // firebase 환경설정 추가
        FirebaseApp.configure()
        return true
    }
}
