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
        ZStack{
            VStack{
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                    .edgesIgnoringSafeArea(.all)
                Spacer()
            }
            VStack{
                if let user = viewModel.user {
                    Spacer()
                        .frame(maxHeight: 150)
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color(UIColor(hex: "#ddedb6")))
                        VStack{
                            VStack(alignment: .leading){
                                Text("STAFF")
                                    .font(.system(size: 30))
                                    .foregroundColor(Color(UIColor(hex: "#10621b")))
                                Text("Name:")
                                Text(user.name)
                                Text("Gmail: ")
                                ScrollView(.horizontal){
                                    Text(user.email)
                                }
                                Text("Tel: ")
                                Text(user.tel)
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
                        }
                    }
                } else {
                    Text("Loading Profile")
                }
            }
            .fullScreenCover(isPresented: $showingEditPage, onDismiss: viewModel.fetch) {EditProfileView()}
            .fullScreenCover(isPresented: $showingHistoryPage, onDismiss: viewModel.fetch) {StaffHistory()}
            .padding(30)
            VStack{
                Spacer().frame(height: 50)
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180)
                    .foregroundColor(Color(UIColor(hex: "#9ed461")))
                Spacer()
            }
            VStack{
                Spacer().frame(height: 220)
                HStack{
                    Spacer()
                    Button{
                        showingEditPage = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(Color(UIColor(hex: "#6dad53")))
                    }
                }
                Spacer()
            }.padding(.trailing, 50)

        }
    }
}

#Preview {
    ProfileView()
}
