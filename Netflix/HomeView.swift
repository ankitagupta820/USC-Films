//
//  ContentView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                // Now Playing
                VStack(alignment: .leading){
                    Text("Now Playing").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                    ScrollView(.horizontal){
                        HStack(spacing: 30){
                            
                            ForEach(0..<20){num in
                                
                                NavigationLink(destination: DetailsView(movieID:"Making Their Mark", videoURL:"https://youtu.be/8jVuOheTNGQ", DetailsVM: DetailVM(ticker: "Making Their Mark"))){
                                    
                                    VStack(){
                                        KFImage(URL(string: "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"))
                                            .resizable()
                                            .scaledToFill()
                                            .cornerRadius(5)
                                            .frame(width:150, height:200)
                                        
                                        Text("Movie Name").font(.caption).fixedSize(horizontal: false, vertical: true)
                                        Text("("+"2020"+")").font(.caption)
                                    }.frame(width: 150)
                                    
                                }.background(Color.white)
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                .contextMenu(menuItems: {
                                    let source = "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"
                                    
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
                                        print("Change country setting")
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
                            
                            ForEach(0..<20){num in
                                
                                NavigationLink(destination: DetailsView(movieID:"Making Their Mark", videoURL:"https://youtu.be/8jVuOheTNGQ", DetailsVM: DetailVM(ticker: "Making Their Mark"))){
                                    
                                    
                                    VStack(){
                                        KFImage(URL(string: "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"))
                                            .resizable()
                                            .scaledToFill()
                                            .cornerRadius(5)
                                            .frame(height: 150)
                                        Text("Movie Name").font(.caption).fixedSize(horizontal: false, vertical: true)
                                        Text("("+"2020"+")").font(.caption)
                                    }.frame(width: 100)
                        
                                }.background(Color.white)
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                .contextMenu(menuItems: {
                                    let source = "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"
                                    
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
                                        print("Change country setting")
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
                            
                            ForEach(0..<20){num in
                                
                                NavigationLink(destination: DetailsView(movieID:"Making Their Mark", videoURL:"https://youtu.be/8jVuOheTNGQ", DetailsVM: DetailVM(ticker: "Making Their Mark"))){
                                    
                                    VStack(){
                                        KFImage(URL(string: "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"))
                                            .resizable()
                                            .scaledToFill()
                                            .cornerRadius(5)
                                            .frame(height: 150)
                                        Text("Movie Name").font(.caption).fixedSize(horizontal: false, vertical: true)
                                        Text("("+"2020"+")").font(.caption)
                                    }.frame(width: 100)
                                    
                                }.background(Color.white)
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                                .contextMenu(menuItems: {
                                    let source = "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"
                                    
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
                                        print("Change country setting")
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
        HomeView()
    }
}
