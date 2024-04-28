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
            
            Section(header: Text("Clock History")) {
                if viewModel.timeRecords.isEmpty {
                    Text("No records found")
                } else {
                    ForEach(viewModel.timeRecords, id: \.id) { record in
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Image(systemName: "clock.arrow.circlepath")
                                    .foregroundColor(.green)
                                Text("Clock-In: \(record.clockInTimeFormatted)")
                            }
                            HStack {
                                Image(systemName: "clock.fill")
                                    .foregroundColor(.red)
                                Text("Clock-Out: \(record.clockOutTimeFormatted)")
                            }
                            HStack {
                                Image(systemName: "hourglass.bottomhalf.fill")
                                    .foregroundColor(.purple)
                                Text("Work Duration: \(record.workDurationTimeFormatted)")
                            }
                        }
                        .padding(.vertical)
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
