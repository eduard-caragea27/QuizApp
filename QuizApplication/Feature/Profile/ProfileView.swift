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
        NavigationView {
            VStack(alignment: .leading, spacing: 50) {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("First Name: \(service.userDetails?.firstName ?? "")")
                    Text("Last Name: \(service.userDetails?.lastName ?? "")")
                    Text("Educational Institution: \(service.userDetails?.educationUnit ?? "")")
                    Text("Class/Group: \(service.userDetails?.groups ?? "")")
                }
                
                ButtonComponentView(title: "LogOut", background: .blue, foreground: .white, border: .blue) {
                    service.logout()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color.dustyGray)
            .navigationTitle("Profile")
        }
    }
}
 

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionServiceImplementation())
    }
}
