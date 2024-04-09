//
//  StockItemViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import Foundation

class StockItemViewModel: ObservableObject {
    @Published var product: Product
    
    init(product: Product) {
        self.product = product
    }
}
