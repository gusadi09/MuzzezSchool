//
//  KurikulumCard.swift
//  Muzzez School
//
//  Created by Gus Adi on 01/06/21.
//

import SwiftUI

struct KurikulumCard: View {
  var items: Kurikulum?
  
  var body: some View {
    ZStack {
      HStack {
        VStack {
          Text(items?.title ?? "")
            .font(.system(size: 22))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(10)
        }
        .padding()
        
        Spacer()
      }
    }
    .background(Color(.white))
    .cornerRadius(20)
    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0.0, y: 4)
  }
}

struct KurikulumCards_Previews: PreviewProvider {
  static var previews: some View {
    KurikulumCard()
  }
}
