//
//  customTabBar.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 23/4/2567 BE.
//

import SwiftUI

enum Tabs: Int {
    case home = 0
    case dashboard = 1
    case bill = 2
    case stock = 3
    case profile = 4
}

struct customTabBar: View {
    
    @Binding var selected: Tabs
    
    var body: some View {
        HStack(alignment: .center){
            Button{
                selected = .home
            } label: {
                GeometryReader { geo in
                    ZStack{
                        if(selected == .home){
                            Circle()
                                .frame(height: 70)
                                .foregroundColor(Color(UIColor(hex: "#9ED461")))
                        }
                        
                        VStack(alignment: .center){
                            Image(systemName: "house.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .padding(.bottom, 2)
                            Text("Home")
                                .font(.system(size: 10))
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor((selected == .home) ? Color.white : Color(UIColor(hex: "#387440")))
                    }
                }
            }
            
            
            Button{
                selected = .dashboard
            } label: {
                GeometryReader { geo in
                    if(selected == .dashboard){
                        Circle()
                            .frame(height: 70)
                            .foregroundColor(Color(UIColor(hex: "#9ED461")))
                    }
                    VStack(alignment: .center){
                        Image(systemName: "clipboard.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .padding(.bottom, 2)
                        Text("Dashboard")
                            .font(.system(size: 10))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                }
            }
            
            Button{
                
            } label: {
                GeometryReader { geo in
                    VStack(alignment: .center){
                        Image(systemName: "newspaper.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .padding(.bottom, 2)
                        Text("Bill")
                            .font(.system(size: 10))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                }
            }
            
            Button{
                
            } label: {
                GeometryReader { geo in
                    VStack(alignment: .center){
                        Image(systemName: "shippingbox.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .padding(.bottom, 2)
                        Text("Stock")
                            .font(.system(size: 10))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                }
            }
            
            Button{
                
            } label: {
                GeometryReader { geo in
                    VStack(alignment: .center){
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .padding(.bottom, 2)
                        Text("Profile")
                            .font(.system(size: 10))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    customTabBar(selected: .constant(.home))
}
