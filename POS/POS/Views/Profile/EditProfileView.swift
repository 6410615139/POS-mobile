//
//  EditProfileView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//
//
//import SwiftUI
//
//struct EditProfileView: View {
//    @ObservedObject var viewModel: ProfileViewModel
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        NavigationView {
//            if let user = viewModel.user {
//                Form {
//                    Section(header: Text("Profile")) {
//                        editableField("Full Name:", text: $viewModel.name)
//                        editableField("Telephone:", text: $viewModel.tel)
//                        
//                        Picker("Gender:", selection: $viewModel.gender) {
//                            ForEach(Gender.allCases, id: \.self) { gender in
//                                Text(gender.displayName).tag(gender)
//                            }
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        
//                        Text("Email: \(user.email)").foregroundColor(.gray)
//                        Text("Role: \(user.role.displayName)").foregroundColor(.gray)
//                        
//                        Button("Save Changes") {
//                            viewModel.edit()
//                            presentationMode.wrappedValue.dismiss()
//                        }
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color(UIColor(hex: "#387440")))
//                    }
//                    .listRowBackground(Color(UIColor(hex: "#ddedb6")))
//                }
//                .navigationTitle("Edit Profile")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button("Cancel") {
//                            presentationMode.wrappedValue.dismiss()
//                        }
//                    }
//                }
//            } else {
//                Text("Loading Profile...")
//            }
//        }
//        .onAppear {
//            viewModel.load()
//        }
//    }
//    
//    private func editableField(_ label: String, text: Binding<String>) -> some View {
//        VStack(alignment: .leading) {
//            Text(label).bold()
//            TextField("", text: text)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .cornerRadius(25)
//        }
//    }
//}

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            if let user = viewModel.user {
                ZStack {
                    // Main background color
                    Color(UIColor(hex: "#387440")).edgesIgnoringSafeArea(.all)
                    
                    // Container for form and profile image
                    VStack{
                        // Profile image section
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 90, height: 90)
                                .shadow(radius: 3)
                            
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color(UIColor(hex: "#387440")))
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(UIColor(hex: "#9ED461")), lineWidth: 2))
                        }
                        .padding(.top, 30)
                        
                        // Form
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
                            .listRowBackground(Color(UIColor(hex: "#ddedb6")))
                            
                            // Save button section
                            Section {
                                Button("Save Changes") {
                                    viewModel.edit()
                                    presentationMode.wrappedValue.dismiss()
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(UIColor(hex: "#387440")))
                                .cornerRadius(10)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .onAppear {
                            // To remove only extra separators below the list:
                            UITableView.appearance().tableFooterView = UIView()
                        }
                        .background(Color.clear)
                    }
                }
                .navigationTitle("Edit Profile")
                .navigationBarItems(leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                })
            } else {
                Text("Loading Profile...")
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
    
    private func editableField(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(label).bold()
            TextField("", text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(25)
        }
    }
}


#Preview {
    EditProfileView(viewModel: ProfileViewModel())
}

