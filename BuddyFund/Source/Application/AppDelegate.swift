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

@main
struct Map_Watch_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Home(present: Present())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        return true
    }
}
