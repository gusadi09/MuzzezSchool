//
//  Course.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import Foundation
import SwiftUI

struct Courses: Identifiable, Codable {
  var id = UUID()
  var nama: String
  var image: String
  var harga: Int
  var rating: Double
  var deskripsi: String
  var complete: Bool
  var isBuy: Bool
}

struct Kurikulum: Codable {
  var done: Bool
  var title: String
  var videourl: String
}
