//
//  DoneBuyView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/06/21.
//

import SwiftUI

struct DoneBuyView: View {
  
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      Image(systemName: "checkmark.circle.fill")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(.green)
        .frame(width: 100, height: 100)
        .padding()
      
      Text("Selamat!")
        .font(.system(size: 22))
        .fontWeight(.bold)
      
      Text("Pembelian kelas telah berhasil. Silahkan cek halaman My Course.")
        .frame(width: 250, height: 100)
        .multilineTextAlignment(.center)
      
      Button(action: {
        self.viewController?.dismiss(animated: true, completion: nil)
      }, label: {
        Text("Kembali")
          .font(.system(size: 18))
          .fontWeight(.bold)
          .foregroundColor(.white)
      })
      .padding()
      .padding(.horizontal, 30)
      .background(Color(.systemRed))
      .cornerRadius(15)
    }
  }
}

struct DoneBuyView_Previews: PreviewProvider {
  static var previews: some View {
    DoneBuyView()
  }
}
