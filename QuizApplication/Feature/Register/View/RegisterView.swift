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
        service: RegistrationServiceImplementation())
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            VStack(spacing: 16) {
                InputDetailsView(text: $vm.userDetails.email, placeholder: "Enter your email", keyboardType: .emailAddress, sfSymbol: "envelope")
                InputPasswordView(password: $vm.userDetails.password, placeholder: "Enter your password", sfSymbol: "lock")
                
                Divider()
                InputDetailsView(text: $vm.userDetails.firstName, placeholder: "Enter your first name", keyboardType: .default, sfSymbol: "nil")
                InputDetailsView(text: $vm.userDetails.lastName, placeholder: "Enter your last name", keyboardType: .namePhonePad, sfSymbol: "nil")
                InputDetailsView(text: $vm.userDetails.educationUnit, placeholder: "Enter your educational institution", keyboardType: .namePhonePad, sfSymbol: "nil")
                InputDetailsView(text: $vm.userDetails.groups, placeholder: "Enter your class/group", keyboardType: .namePhonePad, sfSymbol: "nil")
            }
            
            ButtonComponentView(title: "Sign Up", background: Color.darkPurple, foreground: .white, border: .clear) {
                validateInputs()
            }
        }
        .padding(.horizontal, 15)
        .navigationTitle("Register")
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
        if vm.userDetails.email.isEmpty || vm.userDetails.password.isEmpty || vm.userDetails.firstName.isEmpty || vm.userDetails.lastName.isEmpty || vm.userDetails.educationUnit.isEmpty || vm.userDetails.groups.isEmpty {
            vm.isError = true
            errorMessage = "Complete all the fields!"
            return
        }
        
        let validations: [(Bool, String)] = [
            (isValidEmail(vm.userDetails.email), "Your email is invalid"),
            (isValidPassword(vm.userDetails.password), "Your password is invalid")
        ]
        
        for (isValid, message) in validations {
            if !isValid {
                vm.isError = true
                errorMessage = message
                return
            }
        }
        vm.create()
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
        }
        
    }
}
