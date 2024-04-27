//
//  User.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    var id: String?
    var name: String
    let email: String
    var tel: String
    var gender: Gender
    let joined: TimeInterval
    var role: UserRole
}

// TimeRecord to track clock-in and clock-out times
struct TimeRecord: Codable, Identifiable {
    var id: String // Unique identifier for the record
    var userId: String // Reference to the User's ID
    var clockInTime: TimeInterval?
    var clockOutTime: TimeInterval?
    
    // Method to clock in
    mutating func clockIn() {
        self.clockInTime = Date().timeIntervalSince1970 // Records current time as clock-in time
    }
    
    // Method to clock out
    mutating func clockOut() {
        self.clockOutTime = Date().timeIntervalSince1970 // Records current time as clock-out time
    }
    
    // Compute the duration of the work session in hours
    func workDuration() -> TimeInterval? {
        guard let clockIn = clockInTime, let clockOut = clockOutTime else {
            return nil // Ensures both times are set before calculating
        }
        let durationSeconds = clockOut - clockIn // Calculate the difference in seconds
        return durationSeconds / 3600 // Convert seconds to hours
    }

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
