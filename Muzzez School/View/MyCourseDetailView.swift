//
//  MyCourseDetailView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/06/21.
//

import SwiftUI
import Kingfisher

struct MyCourseDetailView: View {
  var item: Courses?
  
  @ObservedObject var dataCourse = LoadDataCourse()
  
  @State var show = false
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
            ForEach(item?.kurikulum ?? [], id: \.id) { items in
              KurikulumCard(items: items)
            }
          }
          .padding()
          .padding(.bottom, 120)
          
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
            
          }
        }
      }
    }
  }
}

struct MyCourseDetailView_Previews: PreviewProvider {
  static var previews: some View {
    MyCourseDetailView()
  }
}
