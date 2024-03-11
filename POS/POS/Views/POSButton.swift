//
//  POSButton.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct POSButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                    .padding(5)
            }
        }
    }
}

#Preview {
    POSButton(title: "Button", background: .blue, action: {} )
}
