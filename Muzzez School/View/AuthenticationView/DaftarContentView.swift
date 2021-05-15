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
import NavigationStack
import FirebaseAuth

struct DaftarContentView: View {
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 20) {
                LogoDaftar().padding(.bottom, 100).padding(.top, 100)
                FormBoxDaftar().padding(.bottom, 150)
            }
            .padding()
        }
        
    }
}

struct DaftarContentView_Previews: PreviewProvider {
    static var previews: some View {
        DaftarContentView()
    }
}

struct LogoDaftar : View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 150, height: 100)
        }
        
    }
}

struct FormBoxDaftar : View {
    @State var email: String = ""
    @State var password: String = ""
    @State var rePass: String = ""
    @State var isChecked: Bool = false
    @State var isShowPass: Bool = false
    var onCommit: (()->Void)?
    
    @EnvironmentObject var navStack: NavigationStack
    
    func toogle(){isChecked = !isChecked;}
    
    var body : some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Register").font(.title).bold()
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
                    print("forgot")
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
            
            Button(action: {
                print("Daftar pressed")
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
                    DispatchQueue.main.async {
                        self.navStack.pop(to: .previous)
                    }
                }, label: {
                    Text("Masuk").font(.callout).bold()
                        .foregroundColor(.red)
                })
            }
        }
        .padding(.all, 30)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4, x: 0, y: 4)
    }
    
    func register() {
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
    }
}
