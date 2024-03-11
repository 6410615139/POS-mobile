//
//  POSApp.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI
import FirebaseCore

@main
struct POSApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
