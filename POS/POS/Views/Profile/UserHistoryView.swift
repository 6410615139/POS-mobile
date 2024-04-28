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
    
    var body: some View {
        NavigationView {
            List {
                // User Details
                Section(header: Text("Profile").font(.headline)) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("Name: \(viewModel.user?.name ?? "Unknown")").font(.body)
                            Text("Role: \(viewModel.user?.role.displayName ?? "Unknown")").font(.subheadline).foregroundColor(.gray)
                        }
                    }
                }
                
                // Clock History Section
                Section(header: Text("Clock History").font(.headline)) {
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
            .listStyle(GroupedListStyle())
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
