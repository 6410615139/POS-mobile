//
//  MainViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import FirebaseAuth

class MainViewModel: ObservableObject {
    @Published var currentUserId = ""
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
