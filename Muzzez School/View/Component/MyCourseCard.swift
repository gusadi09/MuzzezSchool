//
//  MyCourseCard.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/06/21.
//

import SwiftUI
import Kingfisher

struct MyCourseCard: View {
  var item: Courses?
  
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
      
      VStack(alignment: .leading) {
        Text(item?.nama ?? "")
          .font(.system(size: 16))
          .fontWeight(.semibold)
        
        VStack {
          ProgressView(value: Double(countDone(item: item)), total: Double(item?.kurikulum.count ?? 0))
          Text("\(Int(Double(countDone(item: item) / (item?.kurikulum.count ?? 0)) * 100)) % selesai")
            .font(.system(size: 10))
            .foregroundColor(.gray)
        }
      }
    }
  }
  
  func countDone(item: Courses?) -> Int {
    var total = 0
    for i in item?.kurikulum ?? [] {
      if i.done {
        total += 1
      }
    }
    
    return total
  }
}

struct MyCourseCard_Previews: PreviewProvider {
  static var previews: some View {
    MyCourseCard()
  }
}
