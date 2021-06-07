//
//  DaftarContentView.swift
//  Muzzez School
//
//  Created by Gus Adi on 28/04/21.
//

/**
 Register Function : menggunakan fungsi dari firebase yang di sediakan oleh google itu sendiri, dimana sebelum login jika tidak memiliki akun akan melakukan registrasi email dan password yang nantinya disimpan pada server yang disediakan google firebase
 
 Dengan contoh syntax :
 Auth.auth().createUser(withEmail: email, password: password) { result, err in
 if err != nil {
 print(err?.localizedDescription ?? "")
 } else {
 print("success")
 DispatchQueue.main.async {
 self.navStack.pop(to: .previous)
 }
 }
 }
 
 Dengan bantuan navigationStack untuk melakukan perpindah page ke Login.
 **/

import SwiftUI
import FirebaseAuth
import Firebase

struct DaftarContentView: View {
  
  @State var email: String = ""
  @State var fName: String = ""
  @State var password: String = ""
  @State var rePass: String = ""
  @State var isChecked: Bool = false
  @State var isShowPass: Bool = false
  @State var show: Bool = false
  var onCommit: (()->Void)?
  
  func toogle(){isChecked = !isChecked;}
  
  @Binding var shouldGoRoot: Bool
  
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    NavigationView{
      ZStack {
        Image("bg")
          .resizable()
          .ignoresSafeArea()
        VStack() {
          VStack(alignment: .center, spacing: 20) {
            
            Text("Register").font(.title).bold()
              .foregroundColor(.black)
            
            TextField("Nama Lengkap", text: $fName)
              .padding()
              .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.secondary, lineWidth: 1)
                        .foregroundColor(.clear))
            
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
              ZStack {
                SecureField("Re-Password", text: $rePass, onCommit: {
                  onCommit?()
                })
                .opacity(isShowPass ? 0 : 1)
                
                if isShowPass {
                  HStack {
                    Text(rePass)
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
              Button(action: {
                toogle()
              }, label: {
                HStack {
                  Image(isChecked ? "checkmark" : "uncheck")
                    .resizable()
                    .frame(width: 20, height: 20)
                  Text("Saya setuju dengan ketentuan dan kebijakan Muzzez School").font(.caption)
                    .foregroundColor(.black).lineLimit(nil).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                  Spacer()
                }
              })
            }
            
            if self.show {
              Text("Mohon periksa semua field dengan baik!")
                .font(.system(size: 12))
                .foregroundColor(.red)
            } else {
              Text("")
                .font(.system(size: 12))
                .foregroundColor(.red)
                .hidden()
            }
            
            
            Button(action: {
              print("Daftar pressed")
              self.register()
            }, label: {
              HStack {
                Spacer()
                Text("Daftar").font(.body).bold()
                Spacer()
              }
            })
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .foregroundColor(.white)
            
            HStack {
              Text("Sudah memiliki akun?")
              Button(action: {
                self.shouldGoRoot = false
              }, label: {
                Text("Masuk").font(.callout).bold()
                  .foregroundColor(.red)
              })
            }
          }
          .padding(.horizontal, 30)
          .padding(.top, 20)
          .padding(.bottom, 30)
          .background(Color.white)
          .cornerRadius(10)
          .shadow(radius: 4, x: 0, y: 4)
        }
        .padding()
      }
      
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarHidden(true)
  }
  
  func register() {
    if password == rePass && isChecked {
      Auth.auth().createUser(withEmail: email, password: password) { result, err in
        if err != nil {
          print(err?.localizedDescription ?? "")
        } else {
          print("success")
          DispatchQueue.main.async {
            writeData(fullName: fName)
            self.viewController?.present(style: .fullScreen, builder: {
              HomeView()
                .ignoresSafeArea()
            })
          }
        }
      }
    } else {
      DispatchQueue.main.async {
        self.show.toggle()
      }
    }
  }
  
  func writeData(fullName: String) {
    let db = Firestore.firestore()
    if let uuid = Auth.auth().currentUser?.uid {
      db.collection("users").document(uuid).setData([
        "id": uuid,
        "nama": fullName,
        "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT18iwsdCCbBfpa50-5BmNa_m_BX087_x1oWQ&usqp=CAU"
      ]) { err in
        if let err = err {
          print("Error writing document: \(err)")
        } else {
          print("Document successfully written!")
        }
      }
    }
  }
}



