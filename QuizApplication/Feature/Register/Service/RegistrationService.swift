//
//  RegistrationService.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 23.04.2023.
//
import Combine
import Foundation
import FirebaseDatabase
import Firebase

enum RegistrationKeys: String {
    case firstName
    case lastName
    case educationUnit
    case groups
}

struct RegistrationDetails {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var educationUnit: String
    var groups: String
}

protocol RegistrationService {
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error>
}

final class RegistrationServiceImplementation: RegistrationService {
    
    func register(with details: RegistrationDetails) -> AnyPublisher<Void, Error> {
        
        Deferred {
            
            Future { promise in
                Auth.auth().createUser(withEmail: details.email,
                                       password: details.password) { res, error in
                    
                    if let err = error {
                        
                        promise(.failure(err))
                        
                    } else {
                        
                        if let uid = res?.user.uid {
                            
                            let values = [RegistrationKeys.firstName.rawValue: details.firstName,
                                          RegistrationKeys.lastName.rawValue: details.lastName,
                                          RegistrationKeys.educationUnit.rawValue: details.educationUnit,
                                          RegistrationKeys.groups.rawValue: details.groups] as [String : Any]
                            
                            Database
                                .database()
                                .reference()
                                .child("users")
                                .child(uid)
                                .updateChildValues(values) { error, ref in
                                    
                                    if let err = error {
                                        promise(.failure(err))
                                    } else {
                                        promise(.success(()))
                                    }
                                }
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
