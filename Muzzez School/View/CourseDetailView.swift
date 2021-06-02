//
//  ContentView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI
import Kingfisher
import Firebase

struct CourseDetailView: View {
  
  var item: Courses?
  
  @ObservedObject var dataCourse = LoadDataCourse()
  @ObservedObject var writeServ = WriteDataService()
  
  @State var show = false
  @State var loveIcon = false
  @State var viewState = CGSize.zero
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    ZStack {
      
      BlurView(style: .systemMaterial)
      
      ZStack(alignment: .topLeading) {
        
        
        
        ScrollView(.vertical, showsIndicators: false) {
          
          TitleView(text: item?.nama ?? "")
            .blur(radius: show ? 20 : 0)
            .animation(.default)
            .padding(.top, 120)
          
          VStack {
            KFImage(URL(string: item?.image ?? ""))
              .resizable()
              .loadDiskFileSynchronously()
              .cacheMemoryOnly()
              .fade(duration: 0.25)
              .resizable()
              .cornerRadius(20)
              .frame(height: 220)
              .padding(.horizontal)
              .padding(.bottom, 20)
            
            Spacer()
          }
          
          VStack {
            ForEach(item?.deskripsi.components(separatedBy: "\\n") ?? [""], id: \.self) { i in
              
              Text("\(i)")
                .multilineTextAlignment(.leading)
                .padding(.bottom, 5)
              
            }
          }
          .padding(.horizontal)
          .padding(.bottom, 15)
          
          VStack {
            ForEach(item?.kurikulum ?? [], id: \.id) { items in
              KurikulumCard(items: items)
            }
          }
          .padding()
          
        }
        
        VStack {
          HStack {
            Button(action: {
              self.viewController?.dismiss(animated: true, completion: nil)
            }, label: {
              
              Image(systemName: "chevron.left")
                .padding()
                .background(Color(.white))
                .foregroundColor(.black)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0.0, y: 4)
            })
            .padding(.leading)
            .padding(.top, 60)
            
            Spacer()
            
            Button(action: {
              self.loveIcon.toggle()
         
              writeServ.writeWishlist(kurikulum: item?.kurikulum, id: item?.id, isLove: loveIcon, nama: item?.nama, image: item?.image, price: item?.harga, rate: item?.rating, desc: item?.deskripsi)
              
            }, label: {
              
              if loveIcon {
                Image(systemName: "heart.fill")
                  .padding()
                  .background(Color(.white))
                  .foregroundColor(.red)
                  .cornerRadius(10)
                  .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0.0, y: 4)
              } else {
                Image(systemName: "heart")
                  .padding()
                  .background(Color(.white))
                  .foregroundColor(.black)
                  .cornerRadius(10)
                  .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0.0, y: 4)
              }
              
            })
            .padding(.trailing)
            .padding(.top, 60)
          }
          
          Spacer()
          
          HStack {
            Text("Rp. \(item?.harga ?? 999999999)")
              .font(.system(size: 20))
              .fontWeight(.bold)
              .padding(.horizontal)
              .padding(.vertical)
            
            Spacer()
            
            Button(action: {
              writeServ.writeCart(kurikulum: item?.kurikulum, isLove: item?.isWishlist, id: item?.id, nama: item?.nama, image: item?.image, price: item?.harga, rate: item?.rating, desc: item?.deskripsi)
            }, label: {
              Image(systemName: "cart.badge.plus")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 40, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .padding(.horizontal, 30)
                .background(Color(.red))
                .cornerRadius(15)
            })
            .padding(.horizontal)
            .padding(.vertical)
            
          }
          .padding(.bottom, 30)
          .background(Color.white)
          .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0.0, y: -4)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    CourseDetailView()
  }
}

struct TitleView: View {
  var text: String = "Course Detail"
  var body: some View {
    return VStack {
      HStack {
        Text("\(text)")
          .font(.largeTitle)
          .fontWeight(.heavy)
        
        Spacer()
      }.foregroundColor(.black)
    }.padding(.horizontal)
    .padding(.top)
    .padding(.bottom, 10)
  }
}

