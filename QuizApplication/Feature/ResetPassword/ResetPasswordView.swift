//
//  ResetPasswordView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 22.04.2023.
//

import SwiftUI

struct ResetPasswordView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                InputDetailsView(text: .constant(""), placeholder: "Enter your email", keyboardType: .emailAddress, sfSymnol: "envelope")
                
                ButtonComponentView(title: "Send", background: .blue, foreground: .white, border: .blue) {
                    
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Reset Password")
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
