//
//  LoginView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 09.04.2023.
//

import SwiftUI

struct LoginView: View {
    @State private  var showRegistration = false
    @State private var showForgotPassword = false
    
    var body: some View {
        
        VStack(spacing: 150) {
            
            VStack(spacing: 16) {
                InputDetailsView(text: .constant(""),
                                 placeholder: "Email",
                                 keyboardType: .emailAddress,
                                 sfSymnol: "envelope")
                
                InputPasswordView(password: .constant(""),
                                  placeholder: "Your password",
                                  sfSymbol: "lock")
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ResetPasswordView(),
                                   isActive: $showForgotPassword,
                                   label: {
                        Button(action: {
                            showForgotPassword.toggle()
                        }, label: {
                            Text("Forgot Password?")
                        })
                        .font(.system(size: 16, weight: .bold))
                    })
                    
                }
            }
            
            VStack(spacing: 22) {
                ButtonComponentView(title: "Login", background: .blue, foreground: .white, border: .clear) { }
                
                NavigationLink(destination: RegisterView(),
                               isActive: $showRegistration,
                               label: {
                    ButtonComponentView(title: "Register", background: .white, foreground: .blue, border: .blue) {
                        showRegistration.toggle()
                    }
                })
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Login")
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
