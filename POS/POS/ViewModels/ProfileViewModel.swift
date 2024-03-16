////
////  ProfileViewModel.swift
////  POS
////
////  Created by ชลิศา ธรรมราช on 14/3/2567 BE.
////
//
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//
//class ProfileViewModel {
//    var user: User = User(id: "", name: "", email: "", joined: 0.0)
//
//    func fetchUserName() -> String {
//        guard let user = Auth.auth().currentUser else {
//            print("No authenticated user found")
//            return ""
//        }
//
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(user.uid)
//
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//                if let userName = document.get("name") as? String {
//                    print("User name: \(userName)")
//                    return userName
//                } else {
//                    print("User name not found")
//                }
//            } else {
//                print("Document does not exist")
//            }
//        }
//        return ""
//    }
//
//}
//
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//import Combine
//
//class ProfileViewModel: ObservableObject {
//    @Published var user: User
//
//    init() {
//        guard let firebaseUser = Auth.auth().currentUser else {
//            print("No authenticated user found")
//            return
//        }
//
//        let db = Firestore.firestore()
//        let userRef = db.collection("users").document(firebaseUser.uid)
//
//        userRef.getDocument { [weak self] (document, error) in
//            if let document = document, document.exists {
//                if let userData = document.data() {
//                    let id = firebaseUser.uid
//                    let name = userData["name"] as? String ?? ""
//                    let email = userData["email"] as? String ?? ""
//                    let joined = userData["joined"] as? TimeInterval ?? 0.0
//              //      DispatchQueue.main.async {
//                    self!.user = User(id: id, name: name, email: email, joined: joined)
//                    print(name)
//                    print(self!.user.name)
//                        
//                 //   }
//                } else {
//                    print("User name not found")
//                }
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
//}

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var user: User? = nil
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId).getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.user = User(
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0
                    )
                }
            }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
