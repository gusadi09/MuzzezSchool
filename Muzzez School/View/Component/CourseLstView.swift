//
//  CourseLstView.swift
//  Muzzez School
//
//  Created by Gus Adi on 29/05/21.
//

import SwiftUI
import Kingfisher

struct CourseLstView: View {
  
  var item: Courses?
  
  var body: some View {
    return VStack(alignment: .leading) {
      ZStack(alignment: .topTrailing) {
        KFImage(URL(string: item?.image ?? ""))
          .resizable()
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .aspectRatio(contentMode: .fill)
          .frame(width: 246, height: 150)
          .padding(.bottom, 20)
        
        if item?.isWishlist ?? true {
          Image(systemName: "heart.fill")
            .padding()
            .foregroundColor(.red)
        } else {
          Image(systemName: "heart")
            .padding()
            .foregroundColor(.red)
        }
      }
      
      Spacer()
      
      Text(item?.nama ?? "")
        .font(.system(size: 22))
        .fontWeight(.bold)
        .foregroundColor(.black)
        .padding(.horizontal, 20)
        .padding(.bottom, 5)
        .lineLimit(4)
      
      HStack {
        Image(systemName: "star.fill")
          .resizable()
          .frame(width: 18, height: 18)
          .foregroundColor(.yellow)
          .padding(.leading, 20)
          .padding(.bottom, 5)
        
        Text("\(String(format: "%.1f", item?.rating ?? 0.0)) / 5")
          .font(.system(size: 18))
          .foregroundColor(.black)
          .padding(.bottom, 5)
          .lineLimit(4)
      }
      
      Text("Rp. \(item?.harga ?? 0)")
        .font(.system(size: 20))
        .foregroundColor(.black)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .lineLimit(4)
    }
    .background(Color(.white))
    .cornerRadius(30)
    .frame(width: 246, height: 350)
    .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 20)
  }
}

struct CourseLstView_Previews: PreviewProvider {
  static var previews: some View {
    CourseLstView()
  }
}
