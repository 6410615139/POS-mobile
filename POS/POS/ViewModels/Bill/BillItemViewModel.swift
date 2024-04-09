//
//  BillItemViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class BillItemViewModel: ObservableObject {
    
//    func toggleIsDone(item: Bill) {
//        var itemCopy = item
//        itemCopy.setDone(!item.isDone)
//        
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return
//        }
//        
//        let db = Firestore.firestore()
//        db.collection("bills")
//            .document(itemCopy.id)
//            .setData(itemCopy.asDictionary())
//    }
    
    func viewDetail(item: Bill) {
        var itemCopy = item
        
        
    }
}
