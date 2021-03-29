//
//  WatchlistView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import Foundation
import SwiftUI
import Kingfisher

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
                        NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: item.movieID, isMovie: true, movieTMDBLink: item.TMDBLink))) {
                            KFImage(URL(string: item.imgURL))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onDrag({
                                    watchListVM.currentMovieTV = item
                                    return NSItemProvider(contentsOf: URL(string: item.title))!
                                })
                                .onDrop(of: [.text], delegate: DropViewDelegate(item: item, watchListVM: watchListVM))
                                .highPriorityGesture(DragGesture.init())
                                .contextMenu(menuItems: {
                                    let source: String = String(item.TMDBLink)//movie.imgURL
                                   // debugPrint("Soruce ",source)
                                   
                                    //Twitter
                                    let TwitterShareString = String("https://twitter.com/intent/tweet?text=Check out this link: &url=\(source)&hashtags=CSCI571NetflixApp")
                                    let escapedShareString = TwitterShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let twitterUrl: URL = URL(string: escapedShareString)!
                                    
                                    //Facebook
                                    let FacebookShareString = String("https://www.facebook.com/sharer/sharer.php?u="+source)
                                    let escapedFacebook = FacebookShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let fbUrl: URL = URL(string:escapedFacebook)!
                                    
                                    Button {
                                        DefaultsStorage.remove(key: item.movieID)
                                        self.watchListVM.refresh()
                                    } label: {
                                       
                                        Label("Remove from watchList", systemImage:"bookmark.fill")
                                        
                                    }
                                    
                                  //  Link(destination: YoutubeShareUrl, label: {Label("Watch Trailer", systemImage: "film")})
                                    Link(destination: fbUrl, label: {Label("Share on Facebook", image: "Facebook")})
                                    Link(destination: twitterUrl, label: {Label("Share on Twitter", image: "Twitter")})
                                    
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

