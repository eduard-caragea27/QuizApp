//
//  ResetPasswordService.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 19.06.2023.
//

import Foundation
import Combine
import FirebaseAuth

protocol ResetPasswordService {
    func sendPassReset(to email: String) -> AnyPublisher<Void, Error>
}

final class ResetPasswordServiceImplementation: ResetPasswordService {
    
    func sendPassReset(to email: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        promise(.success(()))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
