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
      if ProcessInfo.processInfo.environment["unit_tests"] == "true" {
        print("setting up Firebase emulator")
        let setting = Firestore.firestore().settings
        setting.host = "localhost:8080"
        setting.isPersistenceEnabled = false
        setting.isSSLEnabled = false
        Firestore.firestore().settings = setting
      }
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
