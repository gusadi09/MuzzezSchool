//
//  WriteDataWishlist.swift
//  Muzzez School
//
//  Created by Gus Adi on 02/06/21.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class WriteDataService: ObservableObject {
  
  let objectWillChange = ObservableObjectPublisher()
  
  private let db = Firestore.firestore()
  
  func writeWishlist(kurikulum: [Kurikulum]?, id: Int?, isLove: Bool, nama: String?, image: String?, price: String?, rate: Double?, desc: String?) {
    let dataRef = db.collection("courses").document("\(id ?? 0)")
    var kurs = [[String: Any]]()
    
    if isLove {
      dataRef.updateData([
        "isWishlist" : isLove
      ])
      
      for i in kurikulum ?? [] {
        let kur = [
          "title" : i.title,
          "done" : i.done,
          "videourl": i.videourl
        ] as [String : Any]
        
        kurs.append(kur)
      }
      
      db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("wishlist").document("\(id ?? 0)").setData([
        "id": id ?? 0,
        "nama": nama ?? "",
        "image": image ?? "",
        "harga": price ?? "",
        "rating": rate ?? 0.0,
        "deskripsi": desc ?? "",
        "isWishlist" : isLove,
        "kurikulum": kurs
      ])
    } else {
      dataRef.updateData([
        "isWishlist" : isLove
      ])
      
      db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("wishlist").document("\(id ?? 0)").delete() { err in
        if let err = err {
          print("Error removing document: \(err)")
        } else {
          print("Document successfully removed!")
        }
      }
    }
  }
  
  func writeMyCourse(kurikulum: [Kurikulum]?, id: Int?, nama: String?, image: String?, rate: Double?, desc: String?) {
    var kurs = [[String: Any]]()
    
    for i in kurikulum ?? [] {
      let kur = [
        "title" : i.title,
        "done" : i.done,
        "videourl": i.videourl
      ] as [String : Any]
      
      kurs.append(kur)
    }
    
    db.collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("myCourse").document("\(id ?? 0)").setData([
      "id": id ?? 0,
      "nama": nama ?? "",
      "image": image ?? "",
      "rating": rate ?? 0.0,
      "deskripsi": desc ?? "",
      "kurikulum": kurs
    ])
  }
}

