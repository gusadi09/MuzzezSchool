//
//  HomeFrstView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI

struct HomeFrstView: View {
    
    var courses = coursesData
    var tips = tipsDummy
    @State var showContent = false
    @Environment(\.viewController) private var viewControllerHolder: ViewControllerHolder
    
    private var viewController: UIViewController? {
        self.viewControllerHolder.value
    }
    
    var body: some View {
        NavigationView {
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
                            ForEach(courses) { item in
                                GeometryReader { geometry in
                                    CourseLstView(title: item.title,
                                                  image: item.image,
                                                  color: item.color,
                                                  shadowColor: item.shadowColor)
                                        .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                                        .onTapGesture {
                                            self.viewController?.present(style: .fullScreen, builder: {
                                                CourseDetailView()
                                                  .ignoresSafeArea()
                                            })
                                        }
                                }
                                .frame(width: 246, height: 360)
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 15)
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
                        .padding(.top, 15)
                        .padding(.bottom, 25)
                        Spacer()
                    }
                    
                }
            }
            
            .navigationTitle("Home")
        }
        
    }
}


struct HomeFrstView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFrstView()
    }
}

struct CourseLstView: View {
    
    var title = "Build an app with SwiftUI"
    var image = "Illustration1"
    var color = Color("background3")
    var shadowColor = Color("backgroundShadow3")
    
    var body: some View {
        return VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(30)
                .lineLimit(4)
            
            Spacer()
            
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 246, height: 150)
                .padding(.bottom, 30)
        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 246, height: 360)
        .shadow(color: shadowColor, radius: 20, x: 0, y: 20)
    }
}

let coursesData = [
    Course(title: "Guitar for beginer",
           image: "Illustration1",
           color: Color("background3"),
           shadowColor: Color("backgroundShadow3")),
    Course(title: "Intermediate tricks of guitar",
           image: "Illustration2",
           color: Color("background4"),
           shadowColor: Color("backgroundShadow4")),
    Course(title: "Advanced drum coaching",
           image: "Illustration3",
           color: Color("background7"),
           shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Course(title: "Guitar freestyle concept",
           image: "Illustration4",
           color: Color("background8"),
           shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
    Course(title: "Grand piano course for beginer",
           image: "Illustration5",
           color: Color("background9"),
           shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
]

let tipsDummy = [
    Tips(title: "Take care your instrument", image: "guitarImg"),
    Tips(title: "Take care your instrument", image: "guitarImg"),
    Tips(title: "Take care your instrument", image: "guitarImg"),
    Tips(title: "Take care your instrument", image: "guitarImg"),
    Tips(title: "Take care your instrument", image: "guitarImg")
]
