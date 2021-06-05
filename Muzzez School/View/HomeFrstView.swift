//
//  HomeFrstView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI

struct HomeFrstView: View {
  
  @State var showContent = false
  
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  @ObservedObject var dataCourse = LoadDataCourse()
  
  @ObservedObject var dataTips = LoadTipsData()
  
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
                  .font(.system(size: 36))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
                
                Spacer()
              }
              .padding(.all, 30)
              
              HStack {
                Text("#MuzzezSchool")
                  .font(.system(size: 25))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
                  .padding(.vertical)
                  .padding(.bottom)
                
                Spacer()
              }
              .padding(.horizontal, 30)
            }
            .background(Color(.white))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0.0, y: 4)
            .padding()
            
            
            
            Text("Recommended Course")
              .font(.system(size: 25))
              .fontWeight(.semibold)
              .padding(.horizontal)
              .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 30.0) {
                ForEach(dataCourse.data, id: \.id) { item in
                  GeometryReader { geometry in
                    CourseLstView(item: item, harga: item.harga)
                      .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                      .onTapGesture {
                        DispatchQueue.main.async {
                          self.viewController?.present(style: .fullScreen, builder: {
                            CourseDetailView(item: item, harga: item.harga, loveIcon: item.isWishlist)
                              .ignoresSafeArea()
                          })
                          
                        }
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
                ForEach(dataTips.data) { item in
                  GeometryReader { geometry in
                    TipsCardView(title: item.title, image: URL(string: item.image))
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
          
          
          .navigationTitle("Home")
      }
      
    }
    .onAppear(perform: {
      self.dataCourse.fetchData()
    })
  }
}


struct HomeFrstView_Previews: PreviewProvider {
  static var previews: some View {
    HomeFrstView()
  }
}

