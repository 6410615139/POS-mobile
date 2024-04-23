//
//  customTabBarItem.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 23/4/2567 BE.
//

import SwiftUI

struct customTabBarItem: View {
    @Binding var selectedTab: Int
    var index: Int
    var label: String
    var icon: String
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = index
            }
        }) {
            VStack {
                GeometryReader { geo in
                    ZStack{
                        if(selectedTab == index){
                            Circle()
                                .frame(width: 70)
                                .foregroundColor(Color(UIColor(hex: "#9ED461")))
                        }
                        
                        VStack(alignment: .center){
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                                .padding(.bottom, 2)
                            Text(label)
                                .font(.system(size: 10))
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor((selectedTab == index) ? Color.white : Color(UIColor(hex: "#387440")))
                    }
                }
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, maxHeight: 90)
        }
    }
}

#Preview {
    customTabBarItem(
        selectedTab: .constant(0),
        index: 0,
        label: "label",
        icon: "person")
}
