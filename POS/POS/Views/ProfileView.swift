//
//  ProfileView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var showingEditPage = false
    @State private var showingHistoryPage = false
    
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
                            showingEditPage = true
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
                        Text(user.tel)
                    })
                }
                .padding(30)
                Button {
                    showingHistoryPage = true
                } label: {
                    Text("History")
                }
                
                Button {
                    viewModel.logOut()
                } label: {
                    Text("Log Out")
                }
            } else {
                Text("Loading Profile")
            }
    }
        .fullScreenCover(isPresented: $showingEditPage, onDismiss: viewModel.fetch) {EditProfileView()}
        .fullScreenCover(isPresented: $showingHistoryPage, onDismiss: viewModel.fetch) {StaffHistory()}
    .padding(20)
    }
}

#Preview {
    ProfileView()
}
