//
//  RegisterView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 22.04.2023.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var vm = RegistrationViewModelImplementation(
    service: RegistrationServiceImplementation()
)
    var body: some View {
        
        NavigationView {
                VStack(spacing: 30) {
                    
                    VStack(spacing: 16) {
                        InputDetailsView(text: $vm.userDetails.email, placeholder: "Enter your email", keyboardType: .emailAddress, sfSymnol: "envelope")
                        InputPasswordView(password: $vm.userDetails.password, placeholder: "Enter your password", sfSymbol: "lock")
                        
                        Divider()
                        InputDetailsView(text: $vm.userDetails.firstName, placeholder: "Enter your first name", keyboardType: .namePhonePad, sfSymnol: "nil")
                        InputDetailsView(text: $vm.userDetails.lastName, placeholder: "Enter your last name", keyboardType: .namePhonePad, sfSymnol: "nil")
                        InputDetailsView(text: $vm.userDetails.school, placeholder: "Enter your school", keyboardType: .namePhonePad, sfSymnol: "nil")
                        InputDetailsView(text: $vm.userDetails.groups, placeholder: "Enter your group", keyboardType: .namePhonePad, sfSymnol: "nil")
                    }
                    ButtonComponentView(title: "Sign Up", background: .blue, foreground: .white, border: .blue) {
                        vm.create()
                    }
                }
                .padding(.horizontal, 15)
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("Register")
        }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
