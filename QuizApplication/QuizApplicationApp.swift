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
    
    @StateObject var sessionService = SessionServiceImplementation()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    TabView {
                        ProfileView()
                            .tabItem {
                                Label("Profile", systemImage: "person")
                            }
                            .environmentObject(sessionService)
                        
                        StartQuizView()
                            .tabItem {
                                Label("Quiz", systemImage: "questionmark.circle")
                            }
                    }
                case .loggedOut:
                    LoginView()
                }
            }
        }
    }
}
