//
//  Post.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation

struct Post: Codable {
    let id: String
    let title: String
    let createDate: TimeInterval
    let content: String
    let creator: String
}
