//
//  ProfileView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 22.04.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var service: SessionServiceImplementation
    
    var body: some View {
            VStack(alignment: .leading, spacing: 50) {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("First Name: \(service.userDetails?.firstName ?? "N/A")")
                    Text("Last Name: \(service.userDetails?.lastName ?? "N/A")")
                    Text("School: \(service.userDetails?.school ?? "N/A")")
                    Text("Class: \(service.userDetails?.groups ?? "N/A")")
                    Text("Your score: <PlaceHolders>")
                }
                
                ButtonComponentView(title: "LogOut", background: .blue, foreground: .white, border: .blue) {
                    service.logout()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Profile")
            
        }
    }


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(SessionServiceImplementation())
        }
    }
}
