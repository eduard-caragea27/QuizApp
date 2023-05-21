//
//  InputPasswordView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 09.04.2023.
//

import SwiftUI

struct InputPasswordView: View {
    @Binding var password: String
    let placeholder: String
    let sfSymbol: String
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        ZStack(alignment: .leading ) {
            SecureField(placeholder, text: $password)
                .frame(maxWidth: .infinity, minHeight: 45)
                .padding(.leading, textFieldLeading )
            
            Image(systemName: sfSymbol)
                .font(.system(size: 15, weight: .light))
                .padding(.leading, 5)
            
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray.opacity(0.3)))
    }
}

struct InputPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        InputPasswordView(password: .constant(""), placeholder: "Your password", sfSymbol: "lock")
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Password with sfSymbol")
            .padding()
    }
}
