//
//  EditAkunView.swift
//  Muzzez School
//
//  Created by Gus Adi on 07/06/21.
//

import SwiftUI
import Kingfisher
import Firebase

struct EditAkunView: View {
  
  var items: Users?
  @State var nama = ""
  
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    ZStack {
      
      BlurView(style: .systemMaterial)
      
      ZStack(alignment: .topLeading) {
        
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .center) {
            TitleView(text: "Edit Profile")
              .animation(.default)
              .padding(.top, 5)
            
            KFImage(URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT18iwsdCCbBfpa50-5BmNa_m_BX087_x1oWQ&usqp=CAU"))
              .loadDiskFileSynchronously()
              .cacheMemoryOnly()
              .fade(duration: 0.25)
              .resizable()
              .frame(width: 100, height: 100)
              .cornerRadius(50)
              .padding()
              .padding(.top)
            
            TextField("Nama Lengkap", text: $nama)
              .padding()
              .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.red, lineWidth: 2)
                        .foregroundColor(.clear))
              .padding(.horizontal)
              .padding(.bottom, 15)
            
            TextField("Email", text: .constant(Auth.auth().currentUser?.email ?? ""))
              .padding()
              .foregroundColor(.gray)
              .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 2)
                        .foregroundColor(.clear))
              .padding(.horizontal)
              .disabled(true)
            
            HStack {
              Spacer()
              Button(action: {
                updateDataUser()
              }, label: {
                Text("Simpan")
                  .font(.system(size: 18))
                  .fontWeight(.bold)
                  .foregroundColor(.white)
                  .padding()
              })
              Spacer()
            }
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 30)
            .padding(.top, 60)
          }
          .padding(.top, 120)
        }
        
        VStack {
          HStack {
            Button(action: {
              self.viewController?.dismiss(animated: true, completion: nil)
            }, label: {
              
              Image(systemName: "chevron.left")
                .padding()
                .background(Color(.white))
                .foregroundColor(.black)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0.0, y: 4)
            })
            .padding(.leading)
            .padding(.top, 60)
            
            Spacer()
            
          }
        }
      }
    }
  }
  
  func updateDataUser() {
    let db = Firestore.firestore()
    let dataRef = db.collection("users").document(items?.id ?? "")
    
    dataRef.updateData([
      "nama" : nama
    ]) { err in
      if err != nil {
        print(err?.localizedDescription ?? "")
      } else {
        DispatchQueue.main.async {
          self.viewController?.dismiss(animated: true, completion: nil)
        }
      }
      
    }
  }
  
}

struct EditAkunView_Previews: PreviewProvider {
  static var previews: some View {
    EditAkunView(nama: "")
  }
}
