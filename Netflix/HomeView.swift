
//
//  ContentView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//
import SwiftUI
//import Kingfisher

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
    @State var toastMessage:String = ""
    @State var showToast:Bool = false
    
    // if (!HomeVM.isLoaded) {
    //   show a spinner
    //}
    
    var body: some View {
        if !HomeVM.isLoaded {
            Loading()
        } else {
            NavigationView{
                ScrollView{
                    if HomeVM.isLoaded {
                        if self.typeToggle{
                            MoviesListing
                        }else{
                            TVShowsListing
                        }
                    }
                }
                .toast(isPresented: self.$showToast) {
                    HStack {
                        Text(self.toastMessage)
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
                .padding()
                
            }
            .navigationViewStyle(StackNavigationViewStyle()) //for back button in nested detailedview screen
        }
    }
    
    var MoviesListing: some View{
        
        VStack{
            Carousal(CategoryName: "Now Playing", Listing: self.HomeVM.nowPlayingMovie)
            CategoryList(CategoryName: "Top Rated", Listing: self.HomeVM.topRatedMovie, toastMessage: self.$toastMessage, showToast: self.$showToast)
            CategoryList(CategoryName: "Popular", Listing: self.HomeVM.popularMovie, toastMessage: self.$toastMessage, showToast: self.$showToast)
        }
    }
    
    var TVShowsListing: some View{
        
        VStack{
            Carousal(CategoryName: "Airing Today", Listing: self.HomeVM.airingToday)
            CategoryList(CategoryName: "Top Rated", Listing: self.HomeVM.topRatedTV, toastMessage: self.$toastMessage, showToast: self.$showToast)
            CategoryList(CategoryName: "Popular", Listing: self.HomeVM.popularTV, toastMessage: self.$toastMessage, showToast: self.$showToast)
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
                                RemoteImage(url: movie.imgURL)
                                   // .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width, height:geometry.size.height)
                                    .clipped()
                                    .blur(radius: 40, opaque: true)
                                VStack{
                                    RemoteImage(url: movie.imgURL)
                                       // .resizable()
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
    @Binding var toastMessage:String
    @Binding var showToast:Bool
    @State var bookmarks: [Bool] = Array(repeating: false, count: 500)
    
    var body: some View {
        VStack(alignment: .leading){
            Text(CategoryName).font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
            ScrollView(.horizontal){
                HStack(alignment: .top,spacing: 30){
                    ForEach(Listing.indices, id:\.self){ index in
                        NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: Listing[index].movieID, isMovie:Listing[index].isMovie, movieTMDBLink: Listing[index].TMDBLink))){
                            VStack(){
                                RemoteImage(url: Listing[index].imgURL)
                                    //.resizable()
                                    .aspectRatio(contentMode: .fit)
//                                    .aspectRatio(contentMode: .fill)
//                                    .clipped()
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(10)
                                Text(Listing[index].title)
                                    .font(.caption)
                                    .fontWeight(.heavy)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                
                                Text("("+Listing[index].year+")")
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
                            let source: String = String(Listing[index].TMDBLink)//movie.imgURL
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
                                let movie = Listing[index]
                                if bookmarks[index] {
                                    DefaultsStorage.remove(key: movie.movieID)
                                    self.toastMessage = "\(movie.title) was removed from Watchlist"
                                    bookmarks[index] = false
                                    self.showToast=true
                                } else {
                                    DefaultsStorage.store(key: movie.movieID, movie: MovieTV(
                                                            id: (movie.movieID as NSString).integerValue,
                                                            movieID: movie.movieID, title: movie.title, imgURL: movie.imgURL, isMovie: movie.isMovie, TMDBLink: movie.TMDBLink))
                                    self.toastMessage = "\(movie.title) was added to Watchlist"
                                    bookmarks[index] = true
                                    self.showToast=true
                                }
                                
                                
                            } label: {
                                if (bookmarks[index]) {
                                    Label("Remove from watchList", systemImage:"bookmark.fill")
                                } else {
                                    Label("Add to watchList", systemImage:"bookmark")
                                }
                            }
                            
                          //  Link(destination: YoutubeShareUrl, label: {Label("Watch Trailer", systemImage: "film")})
                            Link(destination: fbUrl, label: {Label("Share on Facebook", image: "Facebook")})
                            Link(destination: twitterUrl, label: {Label("Share on Twitter", image: "Twitter")})
                            
                        })
                        
                    }
                }
            }
        }
        
        .onAppear {
            for index in Listing.indices {
                self.bookmarks[index] = (DefaultsStorage.get(key: Listing[index].movieID) != nil)
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
