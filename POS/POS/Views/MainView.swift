//
//  MainView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var selectedTab: Int = 0
    
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
        VStack(spacing: 0) {
            // Content views
            switch selectedTab {
            case 0:
                AnnounceView(user: user)
            case 1:
                DashboardView()
            case 2:
                BillView()
            case 3:
                StockView()
            case 4:
                ProfileView()
            default:
                Text("Selected tab \(selectedTab)")
            }

            // Custom tab bar
            VStack{
                Rectangle()
                    .foregroundColor(Color(UIColor(hex: "#9ed461")))
                    .frame(height: 7)
                HStack {
                    customTabBarItem(selectedTab: $selectedTab, index: 0, label: "Home", icon: "house.fill")
                    customTabBarItem(selectedTab: $selectedTab, index: 1, label: "Dashboard", icon: "clipboard.fill")
                    customTabBarItem(selectedTab: $selectedTab, index: 2, label: "Bill", icon: "newspaper.fill")
                    customTabBarItem(selectedTab: $selectedTab, index: 3, label: "Stock", icon: "shippingbox.fill")
                    customTabBarItem(selectedTab: $selectedTab, index: 4, label: "Profile", icon: "person.circle")
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
