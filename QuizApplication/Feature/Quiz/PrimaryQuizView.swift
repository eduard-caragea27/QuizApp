//
//  QuizView.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 22.06.2023.
//

import SwiftUI

struct PrimaryQuizView: View {
    @StateObject var quizManager = QuizManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack(spacing: 15) {
                    Text("Start the Quiz")
                        .foregroundColor(Color.darkPurple)
                        .font(.system(size: 30, weight: .bold))
                    Text("Press the button to begin!")
                        .foregroundColor(Color.darkPurple)
                        .font(.system(size: 15, weight: .light))
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

struct PrimaryQuizView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryQuizView()
    }
}
