//
//  MenuItemViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import Foundation

class MenuItemViewModel: ObservableObject {
    
    @Published var billId: String
    
    
    init(billId: String) {
        self.billId = billId
    }

    func addToCart(product: Product) {
        
    }
}
