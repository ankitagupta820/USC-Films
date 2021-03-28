
//
//  ContentView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//
import SwiftUI
import Kingfisher

struct SplashScreenView: View{
    
    @State var endSplash = false
   
    var body: some View{
        HomeView(HomeVM: HomeVM())
        VStack{
//        Text("Hello, world!")
//            .padding()
        }
        .onAppear(perform: animateSplash)
        .opacity(endSplash ? 0 : 1)
    }
    
    func animateSplash(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25){
            withAnimation(Animation.easeOut(duration: 0.50)){
                endSplash.toggle()
            }
        }
    }
    
}

struct HomeView: View {
    
    @ObservedObject var HomeVM: HomeVM
    @State var typeToggle: Bool = true
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                
                if self.typeToggle{
                    MoviesListing
                }else{
                    TVShowsListing
                }
            }
            .navigationBarTitle("Netflix")
            .toolbar {
                ToolbarItem() {
                    Button{
                        self.typeToggle.toggle()
                    }label:{
                        Text(self.typeToggle ? "TV shows" : "Movies")
                    }
                }
            }
        }.padding()
    }
    
    var MoviesListing: some View{
        
        VStack{
            Carousal(CategoryName: "Now Playing", Listing: self.HomeVM.nowPlayingMovie)
            CategoryList(CategoryName: "Top Rated", Listing: self.HomeVM.topRatedMovie)
            CategoryList(CategoryName: "Popular", Listing: self.HomeVM.popularMovie)
        }
    }
    
    var TVShowsListing: some View{
        
        VStack{
            Carousal(CategoryName: "Airing Today", Listing: self.HomeVM.airingToday)
            CategoryList(CategoryName: "Top Rated", Listing: self.HomeVM.topRatedTV)
            CategoryList(CategoryName: "Popular", Listing: self.HomeVM.popularTV)
        }
    }
}

struct Carousal: View{
    
    var CategoryName: String
    var Listing: [Movie]
    
    var body: some View{
        
        VStack(alignment: .leading){
            Text(CategoryName).font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
            GeometryReader { geometry in
                let NowPlaying: [Movie] = Listing
                ImageCarouselView(numberOfImages: NowPlaying.count) {
                    ForEach(NowPlaying){movie in
                        NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: movie.movieID, isMovie:movie.isMovie, movieTMDBLink: movie.TMDBLink))){
                            ZStack{
                                KFImage(URL(string: movie.imgURL))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width, height:geometry.size.height)
                                    .clipped()
                                    .blur(radius: 40, opaque: true)
                                VStack{
                                    KFImage(URL(string: movie.imgURL))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width, height:geometry.size.height)
                                        .clipped()
                                }
                            }
                        }
                    }
                }
            }.frame(height: 300, alignment: .center)
        }
    }
}


struct CategoryList: View{
    
    var CategoryName: String
    var Listing: [Movie]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(CategoryName).font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
            ScrollView(.horizontal){
                HStack(alignment: .top,spacing: 30){
                    ForEach(Listing){movie in
                        NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: movie.movieID, isMovie:movie.isMovie, movieTMDBLink: movie.TMDBLink))){
                            VStack(){
                                KFImage(URL(string: movie.imgURL))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(10)
                                Text(movie.title)
                                    .font(.caption)
                                    .fontWeight(.heavy)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                
                                Text("("+movie.year+")")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                
                            }.frame(width: 100)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .background(Color.white)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .contextMenu(menuItems: {
                            let source: String = String(movie.TMDBLink)//movie.imgURL
                           // debugPrint("Soruce ",source)
                           
                            //Twitter
                            let TwitterShareString = String("https://twitter.com/intent/tweet?text=Check out this link: &url=\(source)&hashtags=CSCI571NetflixApp")
                            let escapedShareString = TwitterShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                            let twitterUrl: URL = URL(string: escapedShareString)!
                            
                            //Facebook
                            let FacebookShareString = String("https://www.facebook.com/sharer/sharer.php?u="+source)
                            let escapedFacebook = FacebookShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                            let fbUrl: URL = URL(string:escapedFacebook)!
                            
                            //Youtube Link
                            //let YoutubeShareUrl: URL = URL(string: source)?
                            
                            Button {
                                //bookmark
                            } label: {
                                Label("Add to watchList", systemImage:"bookmark.fill")
                            }
                            
                          //  Link(destination: YoutubeShareUrl, label: {Label("Watch Trailer", systemImage: "film")})
                            Link(destination: fbUrl, label: {Label("Share on Facebook", image: "Facebook")})
                            Link(destination: twitterUrl, label: {Label("Share on Twitter", image: "Twitter")})
                            
                        })
                    }
                }
            }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
        //HomeView(HomeVM: HomeVM())
    }
}
