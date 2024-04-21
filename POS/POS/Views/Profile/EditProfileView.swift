//
//  EditProfileView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            if let user = viewModel.user {
                Form {
                    Section(header: Text("Profile")) {
                        editableField("Full Name:", text: $viewModel.name)
                        editableField("Telephone:", text: $viewModel.tel)
                        
                        Picker("Gender:", selection: $viewModel.gender) {
                            ForEach(Gender.allCases, id: \.self) { gender in
                                Text(gender.displayName).tag(gender)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text("Email: \(user.email)").foregroundColor(.gray)
                        Text("Role: \(user.role.displayName)").foregroundColor(.gray)
                    }
                    
                    
                    Button("Save Changes") {
                        viewModel.edit()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .navigationTitle("Edit Profile")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            } else {
                Text("Loading Profile...")
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
    
    private func editableField(_ label: String, text: Binding<String>) -> some View {
        HStack {
            Text(label).bold()
            TextField("", text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}


#Preview {
    EditProfileView(viewModel: ProfileViewModel())
}

