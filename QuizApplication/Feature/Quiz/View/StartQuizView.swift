//
//  QuizView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 22.06.2023.
//

import SwiftUI

struct StartQuizView: View {
    @StateObject var quizManager = QuizManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack(spacing: 15) {
                    Text("Start the Quiz")
                        .customTitle()
                    Text("Press the button to begin!")
                        .customText()
                }
                
                NavigationLink {
                    QuizView()
                        .environmentObject(quizManager)
                } label: {
                    QuizButtonView(text: "Go")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color.dustyGray)
        }
    }
}

struct StartQuizView_Previews: PreviewProvider {
    static var previews: some View {
        StartQuizView()
    }
}
