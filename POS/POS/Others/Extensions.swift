//
//  Extensions.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any]{
        guard let data = try? JSONEncoder().encode(self) else {
            return[:]
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return[:]
        }
    }
}
