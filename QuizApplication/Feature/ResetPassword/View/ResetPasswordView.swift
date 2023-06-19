//
//  ResetPasswordView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 22.04.2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @StateObject private var vm = ResetPasswordViewModelImplementation(service: ResetPasswordServiceImplementation())
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                InputDetailsView(text: $vm.email, placeholder: "Enter your email", keyboardType: .emailAddress, sfSymnol: "envelope")
                
                ButtonComponentView(title: "Send", background: .blue, foreground: .white, border: .blue) {
                    vm.sendPassReset()
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
