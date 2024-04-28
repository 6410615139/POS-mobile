//
//  RegisterView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    
    var columns: [GridItem] = [
        GridItem(.fixed(80), spacing: 7, alignment: .leading),
        GridItem(.flexible(), spacing: 7, alignment: .leading)
    ]
    
    var body: some View {
        VStack {
            HeaderLogin(size: 220, flip: true)
                .padding(.bottom, 5)
            
            Text("Staff Register")
                .font(.system(size: 35))
                .fontWeight(.bold)
                .foregroundColor(Color(UIColor(hex: "#387440")))
                .padding(.bottom)
            
            VStack(alignment: .leading) {
                LazyVGrid(columns: columns){
                    Text("Email")
                    TextField("Email Address", text: $viewModel.email)
                        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                        .background(Color(UIColor(hex: "#ddedb6")))
                        .cornerRadius(25)
                    
                    Text("Password")
                    SecureField("Password", text: $viewModel.password)
                        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                        .background(Color(UIColor(hex: "#ddedb6")))
                        .cornerRadius(25)

                    
                    Text("Full name")
                    TextField("Name", text: $viewModel.name)
                        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                        .background(Color(UIColor(hex: "#ddedb6")))
                        .cornerRadius(25)

                    
                    Text("Telephone")
                    TextField("Tel", text: $viewModel.tel)
                        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                        .background(Color(UIColor(hex: "#ddedb6")))
                        .cornerRadius(25)

                    
                    Text("Gender")
                    Picker("Gender", selection: $viewModel.gender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.displayName)
                                .foregroundColor(Color(UIColor(hex: "#387440")))
                                .tag(gender)
                        }
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
            
            Button {
                viewModel.register()
            } label: {
                Text("Sign Up")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .frame(width: 270, height: 50)
            .background(Color(UIColor(hex: "#387440")))
            .cornerRadius(5)
            
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
