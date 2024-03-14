//
//  ProfileView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct ProfileView: View {
    var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor(hex: "#b31464")))
                .frame(width: .infinity, height: 550)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor(hex: "#fecede")))
                .frame(width: .infinity, height: 500)
                .padding(.top, 60)
            VStack{
                Text("")
            }
        }
        .padding(20)
    }
}

#Preview {
    ProfileView()
}
