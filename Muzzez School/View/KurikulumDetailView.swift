//
//  KurikulumDetailView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/06/21.
//

import SwiftUI
import AVKit

struct KurikulumDetailView: View {
  @State var player = AVPlayer()

  var item : Kurikulum
  @State var show = false
  @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
  
  private var viewController: UIViewController? {
    self.viewControllerHolder.value
  }
  
  var body: some View {
    ZStack {
      
      BlurView(style: .systemMaterial)
      
      ZStack(alignment: .topLeading) {

        ScrollView(.vertical, showsIndicators: false) {
          
          VStack {
            VideoPlayerView(player: $player)
              .frame(height: 220)
              .cornerRadius(15)
              .padding(.horizontal)
              .onAppear(perform: {
                self.player = AVPlayer(url: URL(string: item.videourl)!)
                player.play()
              })
            
            TitleView(text: item.title)
              .blur(radius: show ? 20 : 0)
              .animation(.default)
              .padding(.top, 5)
          }
          .padding(.top, 120)

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

struct KurikulumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        KurikulumDetailView(item: Kurikulum(done: false, title: "test", videourl: "https://firebasestorage.googleapis.com/v0/b/muzzezschool-2d693.appspot.com/o/yt1s.com%20-%20Guitar%20Lesson%201%20%20Absolute%20Beginner%20Start%20Here%20Free%2010%20Day%20Starter%20Course.mp4?alt=media&token=07faecc7-9881-412e-882f-d8b73babf7ea"))
    }
}


