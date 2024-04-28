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
    @State private var showConfirmationAlert = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let layout = [
        GridItem(.fixed(60)),
        GridItem(.flexible(minimum: 40), alignment: .leading)
    ]
    
    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 170)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color.white)
                    .edgesIgnoringSafeArea(.all)
                //Spacer()
            }
            VStack{
                if let user = viewModel.user {
                    ZStack{
                        RoundedRectangle(cornerRadius: 22)
                            .foregroundColor(Color(UIColor(hex: "#ddedb6")))
                            .padding(.bottom, 30)
                        VStack{
                            VStack(alignment: .leading){
                                Text(user.role.displayName)
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(UIColor(hex: "#10621b")))
                                    .padding(.vertical, 5)
                                Text("Name-Surname:")
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(Color.white)
                                        .frame(height: 30)
                                    Text(user.name)
                                        .frame(width: 230, height: 30, alignment: .leading)
                                }
                                Text("Gmail: ")
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(Color.white)
                                        .frame(height: 30)
                                    ScrollView(.horizontal){
                                        Text(user.email)
                                    }.padding(.horizontal)
                                }
                                Text("Tel: ")
                                ZStack{
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(Color.white)
                                        .frame(height: 30)
                                    Text(user.tel)
                                        .frame(width: 230, height: 30, alignment: .leading)
                                }
                            }
                            .padding(.horizontal ,30)
                            .padding(.bottom, 20)
                            
                            POSButton(title: "History", background: Color(UIColor(hex: "#9ed461"))){
                                showingHistoryPage = true
                            }
                            .frame(width: 220, height: 50)
                            
                            POSButton(title: "Log Out", background: Color(UIColor(hex: "#387440"))){
                                viewModel.logOut()
                            }
                            .frame(width: 220, height: 50)
                            
                            deleteAccountButton
                        }
                    }.padding(.top, 130)
                } else {
                    Text("Loading Profile")
                    logOutButton
                }
            }
            .fullScreenCover(isPresented: $showingEditPage, onDismiss: viewModel.fetchUser) {EditProfileView(viewModel: viewModel)}
            .fullScreenCover(isPresented: $showingHistoryPage, onDismiss: viewModel.fetchUser) {UserHistoryView(viewModel: viewModel)}
            .padding(.horizontal ,30)
            
            // Picture
            VStack{
                //Spacer().frame(height: 27)
                ZStack{
                    Circle()
                        .frame(width: 150)
                        .foregroundColor(Color.white)
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140)
                        .foregroundColor(Color(UIColor(hex: "#9ed461")))
                }
                .padding(.top, 20)
//                .padding(.bottom, .infinity)
                Spacer()
            }
            
            // Edit Button
            VStack{
                Spacer().frame(height: 152)
                HStack{
                    Spacer()
                    Button{
                        showingEditPage = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(Color(UIColor(hex: "#6dad53")))
                    }
                }
                Spacer()
            }.padding(.trailing, 60)

        }
    }
    
    private var logOutButton: some View {
        Button("Log Out") {
            viewModel.logOut()
        }
        .padding()
        .frame(width: 220, height: 50)
        .background(Color.gray)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
    
    private var deleteAccountButton: some View {
        Button("Delete Account") {
            showConfirmationAlert = true
        }
        .foregroundColor(.red)
        .alert("Are you sure you want to delete your account?", isPresented: $showConfirmationAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                viewModel.deleteAccount { success, error in
                    if success {
                        print("Account deleted")
                    } else {
                        alertMessage = error?.localizedDescription ?? "An error occurred"
                        showAlert = true
                    }
                }
            }
        } message: {
            Text("This action cannot be undone.")
        }
        .padding(.bottom)
    }
}

#Preview {
    ProfileView()
}
