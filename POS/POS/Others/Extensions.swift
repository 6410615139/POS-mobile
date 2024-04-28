//
//  Extensions.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import UIKit
import FirebaseAuth

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

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension PostViewModel {
    // Check if the current user has liked the post
    var isLiked: Bool {
        guard let userId = Auth.auth().currentUser?.uid else { return false }
        return post?.likes.contains { $0.id == userId } ?? false
    }
    
    // Count of likes
    var likeCount: Int {
        return post?.likes.count ?? 0
    }
}

extension TimeRecord {
    var clockInTimeFormatted: String {
        guard let clockInTime = clockInTime else { return "N/A" }
        return formatDate(timeInterval: clockInTime)
    }
    
    var clockOutTimeFormatted: String {
        guard let clockOutTime = clockOutTime else { return "N/A" }
        return formatDate(timeInterval: clockOutTime)
    }
    
    var clockDateFormatted: String {
        guard let clockInTime = clockInTime else { return "N/A" }
        return formatDateMonth(timestamp: clockInTime)
    }

    var workDurationTimeFormatted: String {
        guard let duration = workDuration() else { return "N/A" }
        return formatDuration(duration)
    }

    private func formatDate(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func formatDateMonth(timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM" // Adjust the format to your needs
        return dateFormatter.string(from: date)
    }

    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration)
        let minutes = Int((duration - Double(hours)) * 60)
        return "\(hours)h \(minutes)min"
    }
}
