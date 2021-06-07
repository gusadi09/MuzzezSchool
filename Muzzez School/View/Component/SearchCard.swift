//
//  SearchCard.swift
//  Muzzez School
//
//  Created by Gus Adi on 07/06/21.
//

import SwiftUI
import Kingfisher

struct SearchCard: View {
  var item: Courses?
  var harga = ""
  @StateObject var storeManager = StoreManager()
  var body: some View {
    HStack {
      KFImage(URL(string: item?.image ?? ""))
        .resizable()
        .loadDiskFileSynchronously()
        .cacheMemoryOnly()
        .fade(duration: 0.25)
        .aspectRatio(contentMode: .fill)
        .frame(width: 60, height: 60)
        .cornerRadius(5)
        .padding()
      
      VStack(alignment: .leading) {
        Text(item?.nama ?? "")
          .font(.system(size: 16))
          .fontWeight(.semibold)
        Text("\(self.storeManager.myProducts?.localizedPrice ?? "")")
          .font(.system(size: 14))
          .padding(.horizontal)
      }
      
      Spacer()
    }
    .background(Color(.white))
    .cornerRadius(10)
    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0.0, y: 4)
    .onAppear(perform: {
      self.storeManager.getProducts(productIDs: harga)
    })
  }
}

struct SearchCard_Previews: PreviewProvider {
  static var previews: some View {
    SearchCard()
  }
}
