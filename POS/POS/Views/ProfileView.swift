//
//  ProfileView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    let layout = [
        GridItem(.fixed(60)),
        GridItem(.flexible(minimum: 40), alignment: .leading)
    ]
    
    var body: some View {
        ZStack{
            if let user = viewModel.user {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor(hex: "#b31464")))
                    .frame(width: .infinity, height: 550)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor(hex: "#fecede")))
                    .frame(width: .infinity, height: 500)
                    .padding(.top, 60)
                VStack{
                    HStack{
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                            .foregroundColor(.white)
                    }
                    Spacer()
                        .frame(height: 500)
                }
                VStack(alignment: .leading){
                    HStack{
                        Text("STAFF")
                        Button {
                            
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .foregroundColor(.white)
                        }
                    }
                    Text("< position >")
                    Spacer()
                        .frame(height: 100)
                    Text("Name:")
                    Text(user.name)
                        .padding(10)
                        .frame(width: 300)
                        .border(.white, width: 3)
                    LazyVGrid(columns: layout, content: {
                        Text("Gmail: ")
                        ScrollView(.horizontal){
                            Text(user.email)
                        }
                        Text("Tel: ")
                        Text("mytel")
                    })
                    Button {
                        
                    } label: {
                        Text("History")
                    }
                }
                .padding(30)
                .font(.system(size: 20))
            } else {
                Text("Loading Profile")
            }
    }
    .padding(20)
    .onAppear {
        viewModel.fetchUser()
    }
    }
}

#Preview {
    ProfileView()
}
