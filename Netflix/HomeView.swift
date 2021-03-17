//
//  ContentView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
            NavigationView{
                VStack(){
                    Text("Home View")
                    Spacer()
                    HStack(){
                        
                        NavigationLink(destination: DetailsView(movieID:"Making Their Mark", videoURL:"https://youtu.be/8jVuOheTNGQ", DetailsVM: DetailVM(ticker: "Making Their Mark"))){
                            Text("Detail")
                        }
                        
                        NavigationLink(destination: WatchlistView()){
                            Text("Watchlist")
                        }
                        
                        NavigationLink(destination: SearchView()){
                            Text("Search")
                        }
                    }
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
