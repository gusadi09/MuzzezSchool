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
  
  let objectWillChange = ObservableObjectPublisher()
  
  @Published var data = [Courses]() {
    willSet {
      objectWillChange.send()
    }
  }
  @Published var count = 1
  
  var dataKur = [Kurikulum]()
  private let db = Firestore.firestore()
  
  func fetchData() {
    db.collection("courses").addSnapshotListener { (qSnapshot, err) in
      guard let documents = qSnapshot?.documents else {
        print("No Document")
        return
      }
      
      self.data = documents.map { (qDocSnap) -> Courses in
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
        
        self.fetchKur(id: id ?? 0)
        
        return Courses(id: id ?? 0, nama: name ?? "", image: images ?? "", harga: prices ?? 0, rating: ratings ?? 0.0, deskripsi: desk ?? "", complete: comp ?? false, isBuy: isbuy ?? false, isWishlist: wish ?? false, kurikulum: self.dataKur)
      }
    }
    
    print(self.data)
  }
  
  func fetchKur(id: Int) {
    self.db.collection("courses").document("\(id)").collection("kurikulum").addSnapshotListener { (qs, err) in
      guard let documents = qs?.documents else {
        print("No Document")
        return
      }
      
      self.dataKur = documents.map { (qDocSnap) -> Kurikulum in
        let data = qDocSnap.data()
        
        let title = data["title"] as? String
        let comp = data["done"] as? Bool
        let vid = data["videourl"] as? String
        let datas = Kurikulum(done: comp ?? false, title: title ?? "", videourl: vid ?? "")
        
        return datas
      }
    }
  }
  
}
