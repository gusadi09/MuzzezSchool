//
//  LoadDataCourse.swift
//  Muzzez School
//
//  Created by Gus Adi on 29/05/21.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class LoadDataCourse: ObservableObject {
  @Published var data = [Courses]()
  
  init() {
    let db = Firestore.firestore()
    
    db.collection("courses").addSnapshotListener { (query, error) in
      DispatchQueue.main.async {
        if error != nil {
          print(error?.localizedDescription ?? "")
          return
        } else {
          print("No error")
          if let snap = query?.documentChanges {
            for i in snap {
              let name = i.document.get("nama") as? String
              let images = i.document.get("image") as? String
              let prices = i.document.get("harga") as? Int
              let ratings = i.document.get("rating") as? Double
              let desk = i.document.get("deskripsi") as? String
              let comp = i.document.get("complete") as? Bool
              let isbuy = i.document.get("isBuy") as? Bool
              
              let newdata = Courses(nama: name ?? "Test",
                                    image: images ?? "https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                    harga: prices ?? 0,
                                    rating: ratings ?? 0.0,
                                    deskripsi: desk ?? "",
                                    complete: comp ?? false,
                                    isBuy: isbuy ?? false)
              
              self.data.append(newdata)
            }
            
            print(self.data)
          }
        }
      }
    }
  }
}
