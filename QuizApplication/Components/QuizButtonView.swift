//
//  QuizButtonView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 20.08.2023.
//

import SwiftUI

struct QuizButtonView: View {
    var text : String
    var background: Color = Color.darkPurple
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
    }
}

struct QuizButtonView_Previews: PreviewProvider {
    static var previews: some View {
        QuizButtonView(text: "Next")
    }
}
