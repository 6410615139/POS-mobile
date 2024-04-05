//
//  User.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let tel: String
    let gender: String
    let joined: TimeInterval
}
