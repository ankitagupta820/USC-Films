//
//  WatchlistView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import Foundation
import SwiftUI

struct WatchlistView: View {
    var columns = Array(repeating: GridItem(.flexible(), spacing: 3), count: 3)
    @ObservedObject var watchListVM : WatchListVM
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 3) {
                    ForEach(watchListVM.watchList) { item in
                        NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: item.movieID, isMovie: true, movieTMDBLink: item.TMDBLink))) {
                            RemoteImage(url: item.imgURL)
                                .aspectRatio(contentMode: .fit)
                                .onDrag({
                                    watchListVM.currentMovieTV = item
                                    return NSItemProvider(contentsOf: URL(string: item.title))!
                                })
                                .onDrop(of: [.text], delegate: DropViewDelegate(item: item, watchListVM: watchListVM))
                                .highPriorityGesture(DragGesture.init())
                        }
                       
                    }
                }
                .padding(.leading)
                .padding(.trailing)
            }
            .navigationBarTitle("Watch List")
            .onAppear {
                self.watchListVM.watchList = DefaultsStorage.getMoviesList()
            }
        }
    }
    
}

