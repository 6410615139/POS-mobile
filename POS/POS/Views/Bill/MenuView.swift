//
//  MenuView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct MenuView: View {
    
    @StateObject var viewModel: MenuViewModel
    @FirestoreQuery var items: [Product]
    @State private var billId: String
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    // Specify the size for each item
    private let itemSize: CGSize = CGSize(width: 150, height: 150)
    
    init(billId: String) {
        self._items = FirestoreQuery(collectionPath: "products")
        self._viewModel = StateObject(wrappedValue: MenuViewModel())
        self.billId = billId
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items) { item in
                        MenuItemView(billId: billId, product: item)
                            .frame(width: itemSize.width, height: itemSize.height)
                            .background(Color(UIColor.systemBackground)) // Use appropriate background color
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                }
                .padding()
            }            .navigationTitle("Bills")
            
        }
    }
}
