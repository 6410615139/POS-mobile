//
//  BillView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct BillView: View {
    
    @StateObject var viewModel: BillViewModel
    @FirestoreQuery var items: [Bill]
    
    init() {
        self._items = FirestoreQuery(collectionPath: "bills")
        self._viewModel = StateObject(wrappedValue: BillViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    BillItemView(item: item)
                        .swipeActions {
                            Button {
                                viewModel.delete(id: item.id)
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                        }
                        .tint(.red)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Bill")
            .toolbar {
                Button {
                    viewModel.create_bill()
                } label: {
                    Image(systemName: "plus")
                }
            }
//            .sheet(isPresented: $viewModel.showingnewItemView) {
//                NewBillView(newItemPresented: $viewModel.showingnewItemView)
//            }
        }
    }
}
