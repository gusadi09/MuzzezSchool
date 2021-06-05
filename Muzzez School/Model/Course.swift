//
//  Course.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import Foundation
import SwiftUI

struct Courses: Identifiable, Codable {
  var id: Int
  var nama: String
  var image: String
  var harga: String
  var rating: Double
  var deskripsi: String
  var complete: Bool
  var isBuy: Bool
  var isWishlist: Bool
  var kurikulum: [Kurikulum]
}

struct Kurikulum: Identifiable, Codable {
  var id = UUID()
  var done: Bool
  var title: String
  var videourl: String
}
