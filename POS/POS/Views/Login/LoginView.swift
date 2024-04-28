//
//  LoginView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderLogin(size: 220, flip: false)
                    .padding(.bottom, 5)
//                    .frame(width: .infinity)
                
                Text("Point of Sale")
                    .font(.system(size: 45))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                    .padding(.bottom)

                
//                Form {
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(hex: "#387440")))
                        .padding(.horizontal)
                    
                    TextField("Email Address", text: $viewModel.email)
                        .font(.system(size: 20))
                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(UIColor(hex: "#9ED461")), lineWidth: 5)
                        )
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .padding([.horizontal, .bottom])
                    
                    Text("Password")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(hex: "#387440")))
                        .padding(.horizontal)
                    SecureField("Password", text: $viewModel.password)
                        .font(.system(size: 20))
                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(UIColor(hex: "#9ED461")), lineWidth: 5)
                        )
                        .padding(.horizontal)
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 20)
                
                Button {
                    viewModel.login()
                } label: {
                    Text("LOG IN")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color(UIColor(hex: "#387440")))
                .cornerRadius(5)
                
//                }
                
                VStack {
                    NavigationLink("< Staff Register >", destination:
                        RegisterView())
                    .font(.system(size: 23))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                }
                .padding(.vertical, 7)
            }
        }
    }
}

#Preview {
    LoginView()
}
