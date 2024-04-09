//
//  Table.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 5/4/2567 BE.
//

import SwiftUI

struct StaffHistory: View {
    @StateObject var viewModel = DataTableModel()
    @Environment(\.presentationMode) var presentationMode
    // self.presentationMode.wrappedValue.dismiss()
    
    let layout = [
        GridItem(.fixed(100)),
        GridItem(.flexible(minimum: 200), alignment: .leading),
        GridItem(.fixed(60), alignment: .center),
        GridItem(.fixed(60), alignment: .center)
    ]
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack{
                    Image(systemName: "chevron.backward.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    Text("Staff History")
                }
            }
            .buttonStyle(.plain)
            .frame(alignment: .leading)

            Spacer()
        }
        .padding()
        ScrollView(.horizontal){
            LazyVGrid(columns: layout, content: {
                Text("Positon").bold()
                Text("Name").bold()
                Text("In").bold()
                Text("Out").bold()
                
                ForEach(viewModel.users) { user in
                        Text("position")
                        Text(user.name)
                        Text("-")
                        Text("-")
                }
            })
            .onAppear {
                viewModel.fetchUsers()
            }
        }
        Spacer()
    }
}

#Preview {
    StaffHistory()
}
