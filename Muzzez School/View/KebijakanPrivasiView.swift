//
//  KebijakanPrivasiView.swift
//  Muzzez School
//
//  Created by Gus Adi on 09/06/21.
//

import SwiftUI

struct KebijakanPrivasiView: View {
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    private var viewController: UIViewController? {
      self.viewControllerHolder.value
    }
    
    var body: some View {
      ZStack {
        
        BlurView(style: .systemMaterial)
        
        ZStack(alignment: .topLeading) {
          
          
          
          ScrollView(.vertical, showsIndicators: false) {
            
            TitleView(text: "Kebijakan Privasi")
              .animation(.default)
              .padding(.top, 120)
            
            VStack {
                Text("""
                    Kami menjaga privasi pelanggan dengan serius dan kami hanya akan mengumpulkan dan menggunakan informasi pribadi Anda seperti uraian di bawah ini.

                    Perlindungan data adalah hal yang menyangkut kepercayaan dan privasi Anda sangatlah penting bagi kami. Oleh karena itu, kami hanya akan menggunakan nama anda dan informasi lain yang berhubungan dengan Anda sesuai dengan kebijakan privasi ini. Kami hanya akan mengumpulkan informasi yang penting bagi kami dan kami hanya akan mengumpulkan informasi yang dibutuhkan untuk melakukan urusan dengan Anda.
                    Kami hanya akan menyimpan informasi Anda selama dibutuhkan diwajibkan oleh hukum atau selama informasi tersebut berhubungan dengan tujuan-tujuan yang ada saat informasi dikumpulkan.
                    Anda dapat mengunjungi website ini dan melihat-lihat tanpa harus meninggalkan informasi pribadi. Saat Anda mengunjungi website ini, Anda memiliki status anonim yang tidak akan bisa kami bisa identiifikasi kecuali Anda login menggunakan user name dan password Anda.

                    Kebijakan privasi kami mengikuti kebijakan perundangan-undangan yang berlaku.
                    """)
                    .font(.system(size: 18))
            }
            .padding()
            .padding(.bottom, 20)
            
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
}

struct KebijakanPrivasiView_Previews: PreviewProvider {
    static var previews: some View {
        KebijakanPrivasiView()
    }
}
