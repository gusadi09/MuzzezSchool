//
//  LoadTipsData.swift
//  Muzzez School
//
//  Created by Gus Adi on 29/05/21.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class LoadTipsData: ObservableObject {
  let objectWillChange = ObservableObjectPublisher()
  
  @Published var data = [Tips]() {
    willSet {
      objectWillChange.send()
    }
  }
  
  init() {
    let db = Firestore.firestore()
    
    db.collection("tips").addSnapshotListener { (query, error) in
      DispatchQueue.main.async {
        if error != nil {
          print(error?.localizedDescription ?? "")
          return
        } else {
          print("No error")
          if let snap = query?.documentChanges {
            for i in snap {
              let judul = i.document.get("title") as? String
              let images = i.document.get("image") as? String
              let desk = i.document.get("isi") as? String
              
              let newdata = Tips(title: judul ?? "", image: images ?? "", isi: desk ?? "")
              
              self.data.append(newdata)
            }
            
            print(self.data)
          }
        }
      }
    }
  }
}
