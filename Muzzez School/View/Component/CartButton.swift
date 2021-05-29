//
//  CartButton.swift
//  Muzzez School
//
//  Created by Gus Adi on 29/05/21.
//

import SwiftUI

struct CartButton: View {
    var body: some View {
      ZStack {
        Button(action: {
          
        }, label: {
          Image(systemName: "cart")
            .resizable()
            .frame(width: 35, height: 32)
            .padding(10)
        })
      }
      .padding(10)
      .foregroundColor(.black)
      .background(Color(.white))
      .cornerRadius(20)
      .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 4)
      
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton()
    }
}
