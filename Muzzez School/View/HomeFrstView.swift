//
//  HomeFrstView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI

struct HomeFrstView: View {
  
  var tips = TipsDummy().tipsDummy
  @State var showContent = false
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  @ObservedObject var dataCourse = LoadDataCourse()
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottomTrailing) {
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading) {
            VStack {
              HStack {
                Text("Music is for everyone")
                  .font(.system(size: 40))
                  .fontWeight(.bold)
                  .foregroundColor(.white)
                  .padding(.vertical)
                  .padding(.trailing)
                
                Spacer()
              }
              
              HStack {
                Text("#MuzzezSchool")
                  .font(.system(size: 25))
                  .fontWeight(.bold)
                  .foregroundColor(.white)
                  .padding(.vertical)
                
                Spacer()
              }
            }
            .padding(.all, 30)
            .background(Color("background9"))
            .cornerRadius(20)
            .padding()
            
            Text("Recommended Course")
              .font(.system(size: 25))
              .fontWeight(.semibold)
              .padding(.horizontal)
              .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 30.0) {
                ForEach(dataCourse.data) { item in
                  GeometryReader { geometry in
                    CourseLstView(withURL: item.image, title: item.nama, price: item.harga, rating: item.rating)
                      .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                      .onTapGesture {
                        self.viewController?.present(style: .fullScreen, builder: {
                          CourseDetailView()
                            .ignoresSafeArea()
                        })
                      }
                  }
                  .frame(width: 246, height: 350)
                  
                }
              }
              .padding(.horizontal)
              .padding(.top, 10)
              .padding(.bottom, 45)
              Spacer()
            }
            
            
            Text("Tips")
              .font(.system(size: 25))
              .fontWeight(.semibold)
              .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 30.0) {
                ForEach(tips) { item in
                  GeometryReader { geometry in
                    TipsCardView(title: item.title, image: item.image)
                      .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                      .onTapGesture {
                        self.viewController?.present(style: .fullScreen, builder: {
                          DetailView(item: item)
                            .ignoresSafeArea()
                        })
                      }
                  }
                  .frame(width: 220, height: 220)
                }
              }
              .padding(.horizontal)
              .padding(.top, 10)
              .padding(.bottom, 25)
              Spacer()
            }
            
          }
        }
        
        CartButton()
          .padding()
          
        
        .navigationTitle("Home")
      }
      
    }
  }
}


struct HomeFrstView_Previews: PreviewProvider {
  static var previews: some View {
    HomeFrstView()
  }
}




