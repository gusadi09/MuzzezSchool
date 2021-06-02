//
//  LoadDataUser.swift
//  Muzzez School
//
//  Created by Gus Adi on 31/05/21.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class LoadDataUser: ObservableObject {
  
  let objectWillChange = ObservableObjectPublisher()
  
  @Published var data: Users? {
    willSet {
      objectWillChange.send()
    }
  }
  
  private let db = Firestore.firestore()
  
  var dataWish = [Courses]()
  var dataKur = [Kurikulum]()
  
  func fetchData() {
    var newdata = Users(id: "", nama: "", image: "")
    db.collection("users").addSnapshotListener { (qSnapshot, err) in
      guard let documents = qSnapshot?.documents else {
        print("No Document")
        return
      }
      
      let datas = documents.map { (qDocSnap) -> Users in
        let data = qDocSnap.data()
        
        let id = data["id"] as? String
        let nama = data["nama"] as? String
        let image = data["image"] as? String
        
        self.fetchWishlist(id: id ?? "")
        
        newdata = Users(id: id ?? "", nama: nama ?? "", image: image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT18iwsdCCbBfpa50-5BmNa_m_BX087_x1oWQ&usqp=CAU", wishlist: self.dataWish)
        
        return newdata
      }
      
      for i in datas {
        if let uid = Auth.auth().currentUser?.uid, uid == i.id {
          self.data = Users(id: i.id, nama: i.nama, image: i.image, wishlist: i.wishlist)
        }
      }
    }
  }
  
  func fetchWishlist(id: String) {
    self.db.collection("users").document(id).collection("wishlist").addSnapshotListener { (qs, err) in
      guard let documents = qs?.documents else {
        print("No Document")
        return
      }
      
      self.dataWish = documents.map { (qDocSnap) -> Courses in
        let data = qDocSnap.data()
        
        let id = data["id"] as? Int
        let name = data["nama"] as? String
        let images = data["image"] as? String
        let prices = data["harga"] as? Int
        let ratings = data["rating"] as? Double
        let desk = data["deskripsi"] as? String
        let comp = data["complete"] as? Bool
        let isbuy = data["isBuy"] as? Bool
        let wish = data["isWishlist"] as? Bool
        
        let kurikulum = data["kurikulum"] as? [[String : Any]]
        for kur in kurikulum ?? [] {
          self.dataKur = []
          let title = kur["title"] as? String
          let done = kur["done"] as? Bool
          let vid = kur["videourl"] as? String
          
          let newdata = Kurikulum(done: done ?? false, title: title ?? "", videourl: vid ?? "")
          
          self.dataKur.append(newdata)
        }
        
        return Courses(id: id ?? 0, nama: name ?? "", image: images ?? "", harga: prices ?? 0, rating: ratings ?? 0.0, deskripsi: desk ?? "", complete: comp ?? false, isBuy: isbuy ?? false, isWishlist: wish ?? false, kurikulum: self.dataKur)
      }
    }
  }
}
