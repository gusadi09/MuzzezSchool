//
//  AccountView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

/**
 Logout Function : menggunakan fungsi dari firebase yang di sediakan oleh google itu sendiri, dimana secara langsung melakukan penghentian session dari user pada aplikasi.
 
 Pada halaman akun juga dapat mengedit data user.
 
 Dengan contoh syntax :
 do {
 t ry Auth.auth().signOut()
 self.navStack.pop(to: .previous)
 } catch let signOutError as NSError {
 print ("Error signing out: %@", signOutError)
 }
 
 Dengan bantuan navigationStack untuk melakukan perpindah page ke login.
 **/

import SwiftUI
import FirebaseAuth
import NavigationStack

struct AccountView: View {
  @EnvironmentObject var navStack: NavigationStack
  
  var body: some View {
    NavigationView {
      VStack {
        Image("avatar")
          .resizable()
          .renderingMode(.original)
          .frame(width: 100, height: 100)
          .cornerRadius(50)
          .padding()
          .padding(.top)
        
        Text("Nama")
          .font(.system(size: 22))
          .fontWeight(.bold)
          .padding(.bottom)
        
        Text("Email")
          .font(.system(size: 20))
          .fontWeight(.semibold)
          .padding(.bottom)
        
        Spacer()
        
        HStack {
          Spacer()
          Button(action: {logout()}, label: {
            Text("Logout")
              .font(.system(size: 18))
              .fontWeight(.bold)
              .foregroundColor(.white)
              .padding()
          })
          Spacer()
        }
        .background(Color(.systemRed))
        .cornerRadius(10)
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
        
        
        .navigationTitle("Account")
      }
    }
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
      self.navStack.pop(to: .previous)
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView()
  }
}
