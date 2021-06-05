//
//  Users.swift
//  Muzzez School
//
//  Created by Gus Adi on 31/05/21.
//

import Foundation

import SwiftUI

struct Users: Identifiable {
  var id: String
  var nama: String
  var image: String
  var wishlist: [Courses]?
  var course: [Courses]?
}
