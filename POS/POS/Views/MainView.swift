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
        Group {
            if viewModel.isSignedIn, let user = viewModel.user {
                accountView(for: user)
            } else {
                LoginView()
            }
        }
    }
    
    @ViewBuilder
    private func accountView(for user: User) -> some View {
        TabView {
            AnnounceView(user: user)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "clipboard.fill")
                }
            BillView()
                .tabItem {
                    Label("Bill", systemImage: "newspaper.fill")
                }
            
            StockView()
                .tabItem {
                    Label("Stock", systemImage: "shippingbox.fill")
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
