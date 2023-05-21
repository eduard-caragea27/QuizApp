//
//  RegistrationViewModel.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 30.04.2023.
//

import Foundation
import Combine

enum RegistrationState {
    case successfull
    case failed(error: Error)
    case na
}

protocol RegistrationViewModel {
    func create()
    var service: RegistrationService { get }
    var state: RegistrationState { get }
    var userDetails: RegistrationDetails { get }
    init(service: RegistrationService)
}

final class RegistrationViewModelImplementation: ObservableObject, RegistrationViewModel {
    
    let service: RegistrationService
    @Published var state: RegistrationState = .na
    @Published var userDetails = RegistrationDetails(email: "",
                                                password: "",
                                                firstName: "",
                                                lastName: "",
                                                school: "",
                                                groups: "")
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    init(service: RegistrationService) {
        self.service = service
    }
    
    func create() {
        
        service
            .register(with: userDetails)
            .sink { [weak self] res in
                
                switch res {
                case.failure (let error):
                    self?.state = .failed(error: error)
                default: break
                }
                
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &subscriptions)
    }
}




