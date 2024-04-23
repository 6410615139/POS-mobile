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
                                .frame(width: 100, height: 100)
                                .shadow(radius: 3)
                            
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70)
                                .foregroundColor(Color(UIColor(hex: "#387440")))
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(UIColor(hex: "#9ED461")), lineWidth: 4))
                        }
                        .padding(.top, 20)
                        
                        // Form
                        Form {
                            Section {
                                editableField("Full Name:", text: $viewModel.name)
                                editableField("Telephone:", text: $viewModel.tel)
                                
                                Picker("Gender:", selection: $viewModel.gender) {
                                    ForEach(Gender.allCases, id: \.self) { gender in
                                        Text(gender.displayName)
                                            .foregroundColor(Color(UIColor(hex: "#387440")))
                                            .tag(gender)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.vertical, 3)
                                
                                Text("Email: \(user.email)").foregroundColor(.gray)
                                    .padding(.vertical, 5)
                                Text("Role: \(user.role.displayName)").foregroundColor(.gray)
                                    .padding(.vertical, 5)
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
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(Color(UIColor(hex: "#ddedb6")))
                        .font(.headline)
                        .bold()
                        .padding(.leading, 7)
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
                .foregroundColor(Color(UIColor(hex: "#387440")))
            TextField("", text: text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(25)
        }
    }
}


#Preview {
    EditProfileView(viewModel: ProfileViewModel())
}

