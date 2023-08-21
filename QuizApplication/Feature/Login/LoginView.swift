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
    @State private var errorMessage = ""
    
    @StateObject private var vm = LoginViewModelImplementation(service: LoginServiceImplementation())
    
    var body: some View {
        
        VStack(spacing: 150) {
            
            VStack(spacing: 16) {
                InputDetailsView(text: $vm.credentials.email,
                                 placeholder: "Email",
                                 keyboardType: .emailAddress,
                                 sfSymnol: "envelope")
                
                InputPasswordView(password: $vm.credentials.password,
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
                                .customInfoText()
                        })
                    })
                }
            }
            
            VStack(spacing: 22) {
                ButtonComponentView(title: "Login", background: Color.darkPurple, foreground: .white, border: .clear) {
                    validateInputs()
                }
                
                NavigationLink(destination: RegisterView(),
                               isActive: $showRegistration,
                               label: {
                    ButtonComponentView(title: "Register", background: .white, foreground: Color.darkPurple, border: Color.darkPurple) {
                        showRegistration.toggle()
                    }
                })
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Login")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color.dustyGray)
        .alert(isPresented: $vm.isError,
               content: {
            if case .failed(let error) = vm.state {
                return Alert(title: Text("Error"),
                             message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Error"),
                             message: Text(errorMessage))
            }
        })
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    private func validateInputs() {
        if vm.credentials.email.isEmpty || vm.credentials.password.isEmpty {
            vm.isError = true
            errorMessage = "Please enter your email and password"
            return
        }
        
        let validations: [(Bool, String)] = [
            (isValidEmail(vm.credentials.email), "Your email is invalid"),
            (isValidPassword(vm.credentials.password), "Your password is invalid")
        ]
        
        for (isValid, message) in validations {
            if !isValid {
                vm.isError = true
                errorMessage = message
                return
            }
        }
        
        vm.login()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
