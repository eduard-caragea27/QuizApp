//
//  QuizApplicationApp.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 09.04.2023.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct QuizApplicationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var service = SessionServiceImplementation()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch service.state {
                case .loggedIn:
                    ProfileView()
                        .environmentObject(service)
                case .loggedOut:
                    LoginView()
                }
            }
        }
    }
}
