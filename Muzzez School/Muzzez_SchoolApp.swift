//
//  Muzzez_SchoolApp.swift
//  Muzzez School
//
//  Created by Gus Adi on 28/04/21.
//

import SwiftUI
import Firebase

@main
struct Muzzez_SchoolApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
          if Auth.auth().currentUser != nil {
            HomeView()
          } else {
            LoginContentView()
          }
        }
    }
}
