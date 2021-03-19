//
//  NetflixApp.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import SwiftUI

@main
struct NetflixApp: App {
    
    @State var selection = 2
    var body: some Scene {
        WindowGroup {
            //HomeView()
            TabView(selection:$selection){
                SearchView()
                    .tabItem{Label("Search", systemImage:"magnifyingglass")}
                    .tag(1)
                HomeView(HomeVM: HomeVM())
                    .tabItem{Label("Home", systemImage:"house")}
                    .tag(2)
                WatchlistView(watchListVM: WatchListVM())
                    .tabItem{Label("WatchList", systemImage:"heart")}
                    .tag(3)
            }
        }
    }
}
