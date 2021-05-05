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
            Button(action: {logout()}, label: {
                Text("Logout")
            })
            .navigationTitle("Account")
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
