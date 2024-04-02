//
//  EditProfileView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var viewModel = EditProfileViewModel()
    
    var body: some View {
        if  let user = viewModel.user {
            
        }
    }
}

#Preview {
    EditProfileView()
}

