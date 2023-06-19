//
//  RegisterView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 22.04.2023.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var errorMessage = ""
    
    @StateObject private var vm = RegistrationViewModelImplementation(
        service: RegistrationServiceImplementation()
    )
    var body: some View {
        
        VStack(spacing: 30) {
            
            VStack(spacing: 16) {
                InputDetailsView(text: $vm.userDetails.email, placeholder: "Enter your email", keyboardType: .emailAddress, sfSymnol: "envelope")
                InputPasswordView(password: $vm.userDetails.password, placeholder: "Enter your password", sfSymbol: "lock")
                
                Divider()
                InputDetailsView(text: $vm.userDetails.firstName, placeholder: "Enter your first name", keyboardType: .default, sfSymnol: "nil")
                InputDetailsView(text: $vm.userDetails.lastName, placeholder: "Enter your last name", keyboardType: .namePhonePad, sfSymnol: "nil")
                InputDetailsView(text: $vm.userDetails.educationUnit, placeholder: "Enter your educational institution", keyboardType: .namePhonePad, sfSymnol: "nil")
                InputDetailsView(text: $vm.userDetails.groups, placeholder: "Enter your class/group", keyboardType: .namePhonePad, sfSymnol: "nil")
            }
            
            ButtonComponentView(title: "Sign Up", background: .blue, foreground: .white, border: .blue) {
                if !vm.userDetails.email.isEmpty && !vm.userDetails.password.isEmpty && !vm.userDetails.firstName.isEmpty && !vm.userDetails.lastName.isEmpty && !vm.userDetails.educationUnit.isEmpty && !vm.userDetails.groups.isEmpty {
                    if isValidEmail(vm.userDetails.email) && isValidPassword(vm.userDetails.password) {
                        vm.create()
                    } else {
                        if !isValidEmail(vm.userDetails.email) {
                            vm.isError = true
                            errorMessage = "Your email is invalid"
                        } else if !isValidPassword(vm.userDetails.password) {
                            vm.isError = true
                            errorMessage = "Your password is invalid"
                        }
                    }
                } else {
                    if vm.userDetails.email.isEmpty && vm.userDetails.password.isEmpty && vm.userDetails.firstName.isEmpty && vm.userDetails.lastName.isEmpty && vm.userDetails.educationUnit.isEmpty && vm.userDetails.groups.isEmpty {
                        vm.isError = true
                        errorMessage = "Complete all the fields!"
                    }   else if vm.userDetails.email.isEmpty {
                        vm.isError = true
                        errorMessage = "Please enter your email"
                    } else if vm.userDetails.password.isEmpty {
                        vm.isError = true
                        errorMessage = "Please enter your password"
                    } else if vm.userDetails.firstName.isEmpty {
                        vm.isError = true
                        errorMessage = "Please enter your firstname"
                    } else if vm.userDetails.lastName.isEmpty {
                        vm.isError = true
                        errorMessage = "Please enter your lastname"
                    } else if vm.userDetails.educationUnit.isEmpty {
                        vm.isError = true
                        errorMessage = "Please enter your educational institution"
                    } else if vm.userDetails.groups.isEmpty {
                        vm.isError = true
                        errorMessage = "Please enter your class/group"
                    }
                }
            }
            .padding(.horizontal, 15)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Register")
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
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("Register")
        }
    }
}
