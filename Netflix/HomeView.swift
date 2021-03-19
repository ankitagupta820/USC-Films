//
//  ContentView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @ObservedObject var HomeVM: HomeVM
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                // Now Playing
                VStack(alignment: .leading){
                    Text("Now Playing").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                    ScrollView(.horizontal){
                        HStack(spacing: 30){
                            
                            let NowPlaying: [Movie] = HomeVM.nowPlaying
                           
                            ForEach(NowPlaying){movie in
                                
                                NavigationLink(destination: DetailsView(movieID:movie.title, videoURL:"https://youtu.be/8jVuOheTNGQ", DetailsVM: DetailVM(ticker: movie.title))){
                                    
                                    VStack(){
                                        KFImage(URL(string: movie.imgURL))
                                            .resizable()
                                            .scaledToFill()
                                            .cornerRadius(5)
                                            .frame(width:150)
                                        
                                        Text(movie.title).font(.caption).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                                        Text("("+movie.year+")").font(.caption).multilineTextAlignment(.center)
                                    }.frame(width: 150)
                                    
                                }.background(Color.white)
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                .contextMenu(menuItems: {
                                    let source = movie.imgURL
                            
                                    
                                    //Twitter
                                    let TwitterShareString = String("https://twitter.com/intent/tweet?text=Check out this link: &url=\(source)&hashtags=CSCI571MovieDBApp")
                                    let escapedShareString = TwitterShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let twitterUrl: URL = URL(string: escapedShareString)!
                                    
                                    //Facebook
                                    let FacebookShareString = String("https://www.facebook.com/sharer/sharer.php?u="+source)
                                    let escapedFacebook = FacebookShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let fbUrl: URL = URL(string:escapedFacebook)!
                                    
                                    
                                    //Youtube Link
                                    let YoutubeShareUrl: URL = URL(string: source)!
                                    
                                    
                                    Button {
                                        //add or remove to watchlist
                                    } label: {
                                        Label("Add to watchList", systemImage:"bookmark.fill")
                                    }
                                    
                                    Link(destination: YoutubeShareUrl, label: {Label("Watch Trailer", systemImage: "film")})
                                    Link(destination: fbUrl, label: {Label("Share on Facebook", image: "Facebook")})
                                    Link(destination: twitterUrl, label: {Label("Share on Twitter", image: "Twitter")})
                                    
                                })
                            }
                        }
                    }
                }
                
                
                //Top Rated
                VStack(alignment: .leading){
                    Text("Top Rated").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                    ScrollView(.horizontal){
                        HStack(spacing: 30){
                            
                            let topRated:[Movie] = HomeVM.topRated
                            ForEach(topRated){movie in
                                
                                NavigationLink(destination: DetailsView(movieID: movie.title, videoURL:movie.imgURL, DetailsVM: DetailVM(ticker: movie.title))){
                                    
                                    VStack(){
                                        KFImage(URL(string: movie.imgURL)).renderingMode(.original)
                                            .resizable()
                                            .scaledToFill()
                                            .cornerRadius(5)
                                            .frame(height: 150)
                                            
                                        Text(movie.title).font(.caption).fixedSize(horizontal: false, vertical: true) .multilineTextAlignment(.center)
                                        Text("("+movie.year+")").font(.caption).multilineTextAlignment(.center)
                                    }.frame(width: 100)
                                    
                                }.background(Color.white)
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                .contextMenu(menuItems: {
                                    let source = movie.imgURL
                                    
                                    //Twitter
                                    let TwitterShareString = String("https://twitter.com/intent/tweet?text=Check out this link: &url=\(source)&hashtags=CSCI571StockApp")
                                    let escapedShareString = TwitterShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let twitterUrl: URL = URL(string: escapedShareString)!
                                    
                                    //Facebook
                                    let FacebookShareString = String("https://www.facebook.com/sharer/sharer.php?u="+source)
                                    let escapedFacebook = FacebookShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let fbUrl: URL = URL(string:escapedFacebook)!
                                    
                                    //Youtube Link
                                    let YoutubeShareUrl: URL = URL(string: source)!
                                    
                                    
                                    Button {
                                        //Handle Bookmark
                                    } label: {
                                        Label("Add to watchList", systemImage:"bookmark.fill")
                                    }
                                    
                                    Link(destination: YoutubeShareUrl, label: {Label("Watch Trailer", systemImage: "film")})
                                    Link(destination: fbUrl, label: {Label("Share on Facebook", image: "Facebook")})
                                    Link(destination: twitterUrl, label: {Label("Share on Twitter", image: "Twitter")})
                                    
                                })
                            }
                        }
                    }
                }
                
                //Popular
                VStack(alignment: .leading){
                    Text("Popular").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                    ScrollView(.horizontal){
                        HStack(spacing: 30){
                            
                            let popular:[Movie] = HomeVM.popular
                            ForEach(popular){movie in
                                
                                
                                NavigationLink(destination: DetailsView(movieID:movie.title, videoURL:movie.imgURL, DetailsVM: DetailVM(ticker: movie.title))){
                                    
                                    VStack(){
                                        KFImage(URL(string: movie.imgURL))
                                            .resizable()
                                            .scaledToFill()
                                            .cornerRadius(5)
                                            .frame(height: 150)
                                        Text(movie.title).font(.caption).fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                                        Text("("+movie.year+")").font(.caption).multilineTextAlignment(.center)
                                    }.frame(width: 100)
                                    
                                }.background(Color.white)
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                .contextMenu(menuItems: {
                                    let source = movie.imgURL
                                    
                                    //Twitter
                                    let TwitterShareString = String("https://twitter.com/intent/tweet?text=Check out this link: &url=\(source)&hashtags=CSCI571StockApp")
                                    let escapedShareString = TwitterShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let twitterUrl: URL = URL(string: escapedShareString)!
                                    
                                    //Facebook
                                    let FacebookShareString = String("https://www.facebook.com/sharer/sharer.php?u="+source)
                                    let escapedFacebook = FacebookShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                    let fbUrl: URL = URL(string:escapedFacebook)!
                                    
                                    //Youtube Link
                                    let YoutubeShareUrl: URL = URL(string: source)!
                                    
                                    Button {
                                       //bookmark
                                    } label: {
                                        Label("Add to watchList", systemImage:"bookmark.fill")
                                    }
                                    
                                    Link(destination: YoutubeShareUrl, label: {Label("Watch Trailer", systemImage: "film")})
                                    Link(destination: fbUrl, label: {Label("Share on Facebook", image: "Facebook")})
                                    Link(destination: twitterUrl, label: {Label("Share on Twitter", image: "Twitter")})
                                    
                                })
                            }
                            
                        }
                    }
                }
            }
            .navigationBarTitle("Netflix")
        }.padding()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(HomeVM: HomeVM())
    }
}
