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
import Firebase
import Kingfisher

struct AccountView: View {
  
  @State var currUser = Auth.auth().currentUser
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  @ObservedObject var dataUser = LoadDataUser()
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    NavigationView {
      VStack {
        KFImage(URL(string: dataUser.data?.image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT18iwsdCCbBfpa50-5BmNa_m_BX087_x1oWQ&usqp=CAU"))
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .resizable()
          .frame(width: 100, height: 100)
          .cornerRadius(50)
          .padding()
          .padding(.top)
        
        Text(dataUser.data?.nama ?? "Test")
          .font(.system(size: 22))
          .fontWeight(.bold)
          .padding(.bottom)
        
        Text(currUser?.email ?? "Email")
          .font(.system(size: 20))
          .fontWeight(.semibold)
          .padding(.bottom)
        
        Spacer()
        
        HStack {
          Spacer()
          Button(action: {
            DispatchQueue.main.async {
              self.viewController?.present(style: .fullScreen, builder: {
                EditAkunView(items: dataUser.data, nama: dataUser.data?.nama ?? "")
                  .ignoresSafeArea()
              })
            }
          }, label: {
            Text("Edit Profile")
              .font(.system(size: 18))
              .fontWeight(.bold)
              .foregroundColor(.white)
              .padding()
          })
          Spacer()
        }
        .background(Color(.systemBlue))
        .cornerRadius(10)
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
        
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
    .onAppear(perform: {
      self.dataUser.fetchData()
    })
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
      self.viewController?.present(style: .fullScreen, builder: {
        LoginContentView()
          .ignoresSafeArea()
      })
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
