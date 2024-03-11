//
//  MainView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        if  viewModel.isSignedIn,
            !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        }
    }
    
    var accountView: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    MainView()
}
