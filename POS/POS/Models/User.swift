//
//  User.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let tel: String
    let gender: Gender
    let joined: TimeInterval
    let role: UserRole
}

enum Gender: String, Codable, CaseIterable {
    case male = "male"
    case female = "female"
    case lgbt = "lgbt"
    case undefined = "undefined"
    
    var displayName: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .lgbt:
            return "LGBT"
        case .undefined:
            return "Undefined"
        }
    }
}

enum UserRole: String, Codable, CaseIterable {
    case staff = "staff"
    case manager = "manager"
    case owner = "owner"
    
    var displayName: String {
        switch self {
        case .staff:
            return "Staff"
        case .manager:
            return "Manager"
        case .owner:
            return "Owner"
        }
    }
    
    var isStaff: Bool {
        self == .staff
    }
    
    var isManager: Bool {
        self == .manager
    }
    
    var isOwner: Bool {
        self == .owner
    }
}
