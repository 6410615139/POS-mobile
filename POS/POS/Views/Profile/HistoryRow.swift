//
//  HistoryRow.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 28/4/2567 BE.
//

import SwiftUI

struct HistoryRow: View {
    var timeRecord: TimeRecord

    var columns: [GridItem] = [
        GridItem(.fixed(150), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading),
        GridItem(.fixed(110), spacing: 5, alignment: .leading)
    ]

    var body: some View {
//        HStack {
            LazyVGrid(columns: columns){
                Text(timeRecord.clockDateFormatted)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
                    .background(Color(UIColor(hex: "#ddedb6")))
                
                Text(timeRecord.clockInTimeFormatted)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                    .padding()
                    .frame(maxWidth: .infinity) // Fill the available width
                    .background(Color(UIColor(hex: "#ddedb6")))
                
                Text(timeRecord.clockOutTimeFormatted)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                    .padding()
                    .frame(maxWidth: .infinity) // Fill the available width
                    .background(Color(UIColor(hex: "#ddedb6")))
                
                Text(timeRecord.workDurationTimeFormatted)
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                    .padding()
                    .frame(maxWidth: .infinity) // Fill the available width
                    .background(Color(UIColor(hex: "#ddedb6")))
            }
//        }
    }
}
