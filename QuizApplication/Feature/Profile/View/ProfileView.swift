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
            VStack(alignment: .leading, spacing: 80) {
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("First Name: \(service.userDetails?.firstName ?? "")")
                        .customProfileText()
                    Text("Last Name: \(service.userDetails?.lastName ?? "")")
                        .customProfileText()
                    Text("Educational Institution: \(service.userDetails?.educationUnit ?? "")")
                        .customProfileText()
                    Text("Class/Group: \(service.userDetails?.groups ?? "")")
                        .customProfileText()
                }
                
                ButtonComponentView(title: "Log Out", background: Color.darkPurple, foreground: .white, border: .clear) {
                    service.logout()
                }
                .frame(maxWidth: 360)
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
