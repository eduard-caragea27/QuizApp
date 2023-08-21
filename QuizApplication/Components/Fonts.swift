//
//  Fonts.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 21.08.2023.
//

import Foundation
import SwiftUI

extension Text {
    func customTitle() -> some View {
        self .font(.system(size: 33, weight: .bold))
            .foregroundColor(Color.darkPurple)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
    
    func customProfileText() -> some View {
        self .font(.system(size: 18 , weight: .medium))
            .foregroundColor(Color.darkPurple)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
    
    func customText() -> some View {
        self .font(.system(size: 15 , weight: .light))
            .foregroundColor(Color.darkPurple)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
    
    func customInfoText() -> some View {
        self .font(.system(size: 18 , weight: .bold))
            .foregroundColor(Color.darkPurple)
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
    }
}
