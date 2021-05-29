//
//  CourseLstView.swift
//  Muzzez School
//
//  Created by Gus Adi on 29/05/21.
//

import SwiftUI

struct CourseLstView: View {
  
  var title = "Build an app with SwiftUI"
  var price = 30000
  var rating = 5.0
  
  @ObservedObject var imageLoader:ImageLoader
  @State var images: UIImage = UIImage()
  
  init(withURL url:String, title: String, price: Int, rating: Double) {
    imageLoader = ImageLoader(urlString:url)
    self.title = title
    self.price = price
    self.rating = rating
  }
  
  var body: some View {
    return VStack(alignment: .leading) {
      Image(uiImage: images)
        .resizable()
        .renderingMode(.original)
        .aspectRatio(contentMode: .fill)
        .frame(width: 246, height: 150)
        .padding(.bottom, 20)
      
      Spacer()
      
      Text(title)
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
        
        Text("\(String(format: "%.1f", rating)) / 10")
          .font(.system(size: 18))
          .foregroundColor(.black)
          .padding(.bottom, 5)
          .lineLimit(4)
      }
      
      Text("Rp. \(price)")
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
    CourseLstView(withURL: "https://images.pexels.com/photos/1407322/pexels-photo-1407322.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500", title: "Test", price: 0, rating: 0.0)
  }
}
