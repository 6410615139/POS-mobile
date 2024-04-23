//
//  Post.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation

struct Post: Codable {
    let id: String
    var title: String
    let createDate: TimeInterval
    var content: String
    let creator: String
    var comments: [Comment]
    var likes: [User]
}

struct Comment: Codable {
    let id: String
    let authorId: String
    let content: String
    let timestamp: TimeInterval
}
