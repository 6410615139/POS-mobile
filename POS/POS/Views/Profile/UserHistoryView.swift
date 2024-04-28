//
//  Table.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 5/4/2567 BE.
//

import SwiftUI

struct UserHistoryView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var columns: [GridItem] = [
        GridItem(.fixed(150), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading)
    ]
    
    var body: some View {
        NavigationView {
            List {
                // User Details
                Section(header: Text("Profile").font(.headline).foregroundColor(Color(UIColor(hex: "#387440")))) {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .foregroundColor(Color(UIColor(hex: "#9ed461")))
                            .padding(5)
                        VStack(alignment: .leading) {
                            Text("Name: \(viewModel.user?.name ?? "Unknown")").font(.body)
                            Text("Role: \(viewModel.user?.role.displayName ?? "Unknown")").font(.subheadline).foregroundColor(.gray)
                        }
                        .padding(.leading, 5)
                    }
                }
                
                // Clock History Section
                Section(header: Text("WorkTime History").font(.headline).foregroundColor(Color(UIColor(hex: "#387440")))) {
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
//            .listStyle(GroupedListStyle())
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                    Text("Back")
                }
            })
            .navigationBarTitle("User History", displayMode: .inline)
        }
        .onAppear {
            viewModel.fetchTimeRecords()
        }
    }
}

#Preview {
    UserHistoryView(viewModel: ProfileViewModel())
}
