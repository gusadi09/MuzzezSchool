//
//  ContentView.swift
//  Muzzez School
//
//  Created by Gus Adi on 28/04/21.
//

import SwiftUI
import NavigationStack

struct LoginContentView: View {
    var body: some View {
        NavigationStackView {
            ZStack {
                Image("bg")
                    .resizable()
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Logo().padding(.bottom, 100).padding(.top, 100)
                    FormBox().padding(.bottom, 150)
                }
                .padding()
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

struct FormBox : View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isShowPass: Bool = false
    var onCommit: (()->Void)?
    
    var body : some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Login").font(.title).bold()
                .foregroundColor(.black)
            
            TextField("Email", text: $username)
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
                print("login pressed")
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
                PushView(destination: DaftarContentView()) {
                    Text("Daftar").font(.callout).bold()
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.all, 30)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4, x: 0, y: 4)
    }
}
