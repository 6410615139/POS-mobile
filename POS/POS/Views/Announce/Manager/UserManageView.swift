//
//  UserManageView.swift
//  POS
//
//  Created by Thammasat Thonggamgaew on 21/4/2567 BE.
//

import SwiftUI

struct UserManageView: View {
    @State var user: User
    @State private var isEditing = false
    @StateObject private var viewModel = UserManageViewModel()
    
    var columns: [GridItem] = [
        GridItem(.fixed(150), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading)
    ]
    
    var body: some View {
        Form {
            Section(header: Text("User Info")) {
                if isEditing {
                    TextField("Name", text: $user.name)
                    Picker("Role", selection: $user.role) {
                        ForEach(UserRole.allCases, id: \.self) { role in
                            Text(role.displayName).tag(role)
                        }
                    }
                } else {
                    Text("Name: \(user.name)")
                    Text("Role: \(user.role.displayName)")
                }
            }
            
            Button(isEditing ? "Save" : "Edit") {
                if isEditing {
                    viewModel.updateUserDetail(user) { success, error in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else if success {
                            print("User details updated successfully")
                        }
                    }
                }
                isEditing.toggle()
            }
            
            Section(header: Text("WorkTime History")) {
                if viewModel.timeRecords.isEmpty {
                    Text("No records found")
                } else {
                    ScrollView(.horizontal){
                        LazyVGrid(columns: columns){
                            Text("Date")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center) // Fill the available width
                                .background(Color(UIColor(hex: "#387440")))
                            Text("In")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center) // Fill the available width
                                .background(Color(UIColor(hex: "#387440")))
                            Text("Out")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center) // Fill the available width
                                .background(Color(UIColor(hex: "#387440")))
                            Text("Duration")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center) // Fill the available width
                                .background(Color(UIColor(hex: "#387440")))
                        }
                        
                        ForEach(viewModel.timeRecords, id: \.id) { record in
                            VStack(alignment: .leading, spacing: 5) {
                                HistoryRow(timeRecord: record)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadUserData(for: user)
        }
        .navigationTitle("User Details")
    }
}


#Preview {
    UserManageView(user: User.init(id: "123", name: "Tony Stark", email: "iron@man.com", tel: "0812345678", gender: .male, joined: Date().timeIntervalSince1970, role: .owner))
}
