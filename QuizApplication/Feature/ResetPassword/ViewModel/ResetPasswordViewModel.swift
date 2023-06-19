//
//  ResetPasswordViewModel.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 19.06.2023.
//

import Foundation
import Combine

protocol ResetPasswordViewModel {
    func sendPassReset()
    var email: String { get }
    var service: ResetPasswordService { get }
    init(service: ResetPasswordService)
}

final class ResetPasswordViewModelImplementation: ObservableObject, ResetPasswordViewModel {
    
    @Published var email: String = ""
    var service: ResetPasswordService
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: ResetPasswordService) {
        self.service = service
    }
    
    func sendPassReset() {
        service.sendPassReset(to: email)
            .sink { res in
                switch res {
                case .failure(let err):
                    print("Failed: \(err)")
                default: break
                }
            } receiveValue: {
                print("Sent Password Reset Request")
            }
            .store(in: &subscriptions)
    }
}
