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
        VStack{
            if let user = viewModel.user {
                VStack{
                    HStack{
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                    }
                }
                VStack(alignment: .leading){
                    HStack{
                        Text("STAFF")
                        Button{
                            
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                        }
                    }
                    LazyVGrid(columns: layout, content: {
                        Text("Name:")
                        Text(user.name)
                        Text("Gmail: ")
                        ScrollView(.horizontal){
                            Text(user.email)
                        }
                        Text("Tel: ")
                        Text("mytel")
                    })
                }
                .padding(30)
                Button {

                } label: {
                    Text("History")
                }
                
                Button {
                    
                } label: {
                    Text("Log Out")
                }
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
