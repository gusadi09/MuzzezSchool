//
//  ContentView.swift
//  Muzzez School
//
//  Created by Gus Adi on 28/04/21.
//

/**
 Login Function : menggunakan fungsi dari firebase yang di sediakan oleh google itu sendiri, dimana tiap data login disimpan pada firebase yaitu salah satu service dari Google
 
 Dengan contoh syntax :
 Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
 if error != nil {
 print(error?.localizedDescription ?? "")
 } else {
 print("success")
 DispatchQueue.main.async {
 self.navigationStack.push(HomeView(), withId: "Login")
 }
 }
 }
 
 Dengan bantuan navigationStack untuk melakukan perpindah page ke home.
 **/

import SwiftUI
import FirebaseAuth
import NavigationStack

struct LoginContentView: View {
  
  @State var email: String = ""
  @State var password: String = ""
  @State var isShowPass: Bool = false
  @State var isActive: Bool = false
  var onCommit: (()->Void)?
  @State var isActiveView: Bool = false
  
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        Image("bg")
          .resizable()
          .ignoresSafeArea()
        VStack(spacing: 20) {
          Logo().padding(.bottom, 100).padding(.top, 50)
          VStack(alignment: .center, spacing: 20) {
            Text("Login").font(.title).bold()
              .foregroundColor(.black)
            
            TextField("Email", text: $email)
              .padding()
              .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.secondary, lineWidth: 1)
                        .foregroundColor(.clear))
            
            HStack {
              ZStack {
                SecureField("Password", text: $password, onCommit: {
                  onCommit?()
                })
                .opacity(isShowPass ? 0 : 1)
                
                if isShowPass {
                  HStack {
                    Text(password)
                      .lineLimit(1)
                    
                    Spacer()
                  }
                }
              }
              
              Button(action: {
                isShowPass.toggle()
              }, label: {
                Image(systemName: isShowPass ? "eye.slash.fill" : "eye.fill")
              })
              .accentColor(.secondary)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 12)
                      .stroke(Color.secondary, lineWidth: 1)
                      .foregroundColor(.clear))
            
            HStack {
              Button(action: {print("forgot")}, label: {
                HStack {
                  Spacer()
                  Text("Lupa Password?").font(.callout)
                    .foregroundColor(.gray)
                }
              })
            }
            
            Button(action: {
              login()
              
            }, label: {
              HStack {
                Spacer()
                Text("Masuk").font(.body).bold()
                Spacer()
              }
            })
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .foregroundColor(.white)
            
            HStack {
              Text("Belum punya akun?")
          
              NavigationLink(
                destination: DaftarContentView(shouldGoRoot: self.$isActiveView),
                isActive: self.$isActiveView,
                label: {
                  Text("Daftar").font(.callout).bold()
                    .foregroundColor(.red)
                }).isDetailLink(false)
            }
          }
          .padding(.all, 30)
          .background(Color.white)
          .cornerRadius(10)
          .shadow(radius: 4, x: 0, y: 4)
          .padding()
        }.padding(.bottom, 150)
      }
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarHidden(true)
  }
  func login() {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      if error != nil {
        print(error?.localizedDescription ?? "")
      } else {
        print("success")
        DispatchQueue.main.async {
          self.viewController?.present(style: .fullScreen, builder: {
            HomeView()
              .ignoresSafeArea()
          })
        }
      }
    }
  }
}

struct LoginContentView_Previews: PreviewProvider {
  static var previews: some View {
    LoginContentView()
  }
}

struct Logo : View {
  var body: some View {
    VStack {
      Image("logo")
        .resizable()
        .frame(width: 150, height: 100)
    }
    
  }
}
