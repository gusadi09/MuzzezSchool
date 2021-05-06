//
//  HomeView.swift
//  Muzzez School
//
//  Created by Gus Adi on 05/05/21.
//

import SwiftUI
import NavigationStack

struct HomeView: View {
    var body: some View {
        
        TabView {
            HomeFrstView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            CourseView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Course")
                }
            
            Text("Creative Space")
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Creative Space")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
        }
    }
}
