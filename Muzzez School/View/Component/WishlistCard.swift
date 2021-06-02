//
//  WishlistCard.swift
//  Muzzez School
//
//  Created by Gus Adi on 02/06/21.
//

import SwiftUI
import Kingfisher

struct WishlistCard: View {
  
  var item: Courses?
  
  var body: some View {
    VStack(alignment: .leading) {
      KFImage(URL(string: item?.image ?? "https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"))
        .loadDiskFileSynchronously()
        .resizable()
        .cacheMemoryOnly()
        .fade(duration: 0.25)
        .aspectRatio(contentMode: .fill)
        .frame(height: 150)
        
      Spacer()
      
      Text(item?.nama ?? "test")
        .font(.system(size: 22))
        .fontWeight(.bold)
        .padding(.horizontal)
        .padding(.horizontal)
        .padding(.bottom, 2)
        .padding(.top)
      
      HStack {
        Text("Rp. \(item?.harga ?? 0)")
          .font(.system(size: 20))
          .padding(.horizontal)
        
        Spacer()
        
        Image(systemName: "heart.fill")
          .padding()
          .foregroundColor(.red)
        
//        if item?.isWishlist ?? true {
//          Image(systemName: "heart.fill")
//            .padding()
//            .foregroundColor(.red)
//        } else {
//          Image(systemName: "heart")
//            .padding()
//            .foregroundColor(.red)
//        }
      }
      .padding(.horizontal)
      .padding(.bottom)
    }
    .background(Color(.white))
    .cornerRadius(30)
    .frame(height: 325)
    .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 4)
  }
}

struct WishlistCard_Previews: PreviewProvider {
  static var previews: some View {
    WishlistCard()
  }
}
