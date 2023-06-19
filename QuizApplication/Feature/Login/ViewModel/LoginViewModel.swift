//
//  LoginViewModel.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 16.06.2023.
//

import Foundation
import Combine

enum LoginState {
    case successfull
    case failed(error: Error)
    case na
}

protocol LoginViewModel {
    func login()
    var service: LoginService { get }
    var state: LoginState { get }
    var credentials: LoginCredentials { get }
    var isError: Bool { get }
    init(service: LoginService)
}

final class LoginViewModelImplementation: ObservableObject, LoginViewModel {
    @Published var state: LoginState = .na
    @Published var credentials: LoginCredentials = LoginCredentials.new
    @Published var isError: Bool = false
    
    private var subscriptions = Set<AnyCancellable> ()
    
    let service: LoginService
    
    init(service: LoginService) {
        self.service = service
        setupError()
    }
    
    func login() {
        service.login(with: credentials)
            .sink { res in
                switch res {
                case .failure(let err):
                    self.state = .failed(error: err)
                default: break
                }
                
            } receiveValue: { [weak self] in
                self?.state = .successfull
            }
            .store(in: &subscriptions)
    }
}

private extension LoginViewModelImplementation {
    func setupError() {
        $state.map { state -> Bool in
            switch state {
            case .successfull,
                    .na:
                return false
            case.failed:
                return true
                
            }
        }
        .assign(to: &$isError)
    }
}
