//
//  TextFieldView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 09.04.2023.
//

import SwiftUI

struct InputDetailsView: View {
    
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View {
        ZStack(alignment:  .leading) {
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(maxWidth: .infinity, minHeight: 45)
                .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading )
                .keyboardType(keyboardType)
            
            
            if let systemImage = sfSymbol {
                Image(systemName: systemImage)
                    .font(.system(size: 15, weight: .light))
                    .padding(.leading, 5)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.gray.opacity(0.3)))
    }
}

struct InputDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputDetailsView(text: .constant(""), placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Email with sfSymbol")
                .padding()
            
            InputDetailsView(text: .constant(""), placeholder: "FirstName", keyboardType: .default, sfSymbol: "nil")
                .previewLayout(.sizeThatFits)
                .previewDisplayName("First Name without sfSymbol")
                .padding()
        }
    }
}

