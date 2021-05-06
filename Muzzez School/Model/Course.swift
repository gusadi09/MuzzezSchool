//
//  Course.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import Foundation
import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var shadowColor: Color
}
