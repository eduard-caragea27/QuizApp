//
//  ButtonComponentView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 09.04.2023.
//

import SwiftUI

struct ButtonComponentView: View {
    
    typealias ActionHandler = () -> Void
    
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    
    init(title: String, background: Color, foreground: Color, border: Color, handler: @escaping ButtonComponentView.ActionHandler) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler,
               label:  {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 50)
        })
        
        .background(background)
        .foregroundColor(foreground)
        .font(.system(size: 16, weight: .bold))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(border, lineWidth: 2)
        )
    }
}

struct ButtonComponentView_Prewviews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonComponentView(title: "Primary", background: .blue, foreground: .white, border: .blue) { }
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Primary Button View")
                .padding()
            
            ButtonComponentView(title: "Secondary", background: .white, foreground: .blue, border: .blue) { }
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Secondary Button View")
                .padding()
        }
    }
}
