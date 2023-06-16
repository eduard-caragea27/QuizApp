//
//  SessionService.swift
//  QuizApplication
//
//  Created by Eduard Sorin Caragea on 30.04.2023.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase

enum SessionState {
    case loggedIn
    case loggedOut
}

struct UserSessionDetails {
    let firstName: String
    let lastName: String
    let educationUnit: String
    let groups: String
}

protocol SessionService {
    var state: SessionState { get }
    var userDetails: UserSessionDetails? { get }
    func logout()
    init()
}

final class SessionServiceImplementation: ObservableObject, SessionService {
    
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: UserSessionDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

private extension SessionServiceImplementation {
    
    func setupFirebaseAuthHandler() {
        
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] _,_ in
                guard let self = self else { return }
                
                let currentUser = Auth.auth().currentUser
                self.state = currentUser == nil ? .loggedOut : .loggedIn
                
                if let uid = currentUser?.uid {
                    self.handleRefresh(with: uid)
                }
            }
    }
    
    func handleRefresh(with uid: String) {
        Database
            .database()
            .reference()
            .child("users")
            .child(uid)
            .observe(.value) { [weak self] snapshot in
                guard let self = self else { return }
                
                guard let value = snapshot.value as? NSDictionary,
                      let firstName = value[RegistrationKeys.firstName.rawValue] as? String,
                      let lastName = value[RegistrationKeys.lastName.rawValue] as? String,
                      let educationUnit = value[RegistrationKeys.educationUnit.rawValue] as? String,
                      let groups = value[RegistrationKeys.groups.rawValue] as? String else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.userDetails = UserSessionDetails(firstName: firstName,
                                                          lastName: lastName,
                                                          educationUnit: educationUnit,
                                                          groups: groups)
                }
            }
    }
}


