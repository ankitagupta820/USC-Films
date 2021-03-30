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
            if watchListVM.watchList.count == 0 {
                VStack {
                    Text("Watchlist is empty")
                        .font(.system(size: 26))
                        .foregroundColor(.gray)
                    
                }
                .onAppear {
                    self.watchListVM.refresh()
                }
            } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 3) {
                    ForEach(watchListVM.watchList) { item in
                        NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: item.movieID, isMovie: item.isMovie, movieTMDBLink: item.TMDBLink))) {
                            RemoteImage2(url: item.imgURL)
                               
                                .aspectRatio(contentMode: .fit)
                                .onDrag({
                                    watchListVM.currentMovieTV = item
                                    return NSItemProvider(contentsOf: URL(string: item.title))!
                                })
                                .onDrop(of: [.text], delegate: DropViewDelegate(item: item, watchListVM: watchListVM))
                                .highPriorityGesture(DragGesture.init())
                                .contextMenu(menuItems: {
                                    
                                    Button {
                                        DefaultsStorage.remove(key: item.movieID)
                                        self.watchListVM.refresh()
                                    } label: {
                                        Label("Remove from watchList", systemImage:"bookmark.fill")
                                    }
                                    
                                })
                        }
                       
                    }
                }
                .padding(.leading)
                .padding(.trailing)
            }
            .navigationBarTitle("Watchlist")
            .onAppear {
                self.watchListVM.refresh()
            }
        }
        }
    }
    
}

