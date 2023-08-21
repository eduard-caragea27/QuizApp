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
            VStack(spacing: 20) {
                InputDetailsView(text: $vm.email, placeholder: "Enter your email", keyboardType: .emailAddress, sfSymnol: "envelope")
                
                ButtonComponentView(title: "Send", background: Color.darkPurple, foreground: .white, border: .clear) {
                    vm.sendPassReset()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Reset Password")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color.dustyGray)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
