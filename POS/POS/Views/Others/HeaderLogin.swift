//
//  HeaderLogin.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 28/4/2567 BE.
//

import SwiftUI

struct HeaderLogin: View {
    let size: Double
    let flip: Bool
    
    var body: some View {
        ZStack{
            if (flip) {
                Image("Login_background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .infinity)
                    .scaleEffect(x: -1, y: 1)
                    .padding(.top, 70)
            } else {
                Image("Login_background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .infinity)
                    .padding(.top, 70)
            }
            ZStack{
                Circle()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size)
                Image("Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size-5)
            }
        }
    }
}

#Preview {
    HeaderLogin(size: 220, flip: true)
}
