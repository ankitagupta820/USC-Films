//
//  DetailsView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//
import SwiftUI
import Foundation
import youtube_ios_player_helper
import AVKit
//import Kingfisher


//load this page only when data is fetched
struct DetailsView: View {

    @State var isBookMarked: Bool = false
    @State var toastMessage:String = ""
    @State var showToast:Bool = false
    @State var videoId = NSMutableAttributedString(string: "qxKqMJxw6vc")
    @State var averageStarRating: Float = 4.5
    @ObservedObject var DetailsVM: DetailVM
    @Environment(\.openURL) var openURL

    var body: some View{
        if !DetailsVM.isLoaded {
            Loading()
                .onAppear {
                    self.DetailsVM.fetchDetailPageData()
                }
        } else {
            let layout=[
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            
            ]
            let rows = [
                GridItem(.flexible()), //spacing; between rows
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            //VStack{
                VStack{

                }
                .navigationBarTitle("")

                .toolbar{
                    ToolbarItem(){
                        HStack{
                            Button(action:{
                                self.onBookmark()
                            }){
                                if(self.isBookMarked==true){
                                    Image(systemName: "bookmark.fill")
                                        .renderingMode(.template)
                                        .foregroundColor(Color.blue)
                                }
                                else{
                                    Image(systemName: "bookmark")
                                        .renderingMode(.original)
                                        
                                }
                               
                            }

                            let source: String = String(DetailsVM.movieTMDBLink)
                            Button(action:{
                               
                                let FacebookShareString = String("https://www.facebook.com/sharer/sharer.php?u="+source)
                                let escapedFacebook = FacebookShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                let fbUrl: URL = URL(string:escapedFacebook)!
                                debugPrint("FB uRL ",fbUrl)
                               openURL(fbUrl)
                            }){
                                Image("Facebook")
                                    .resizable()
                                    .foregroundColor(Color.blue)
                                    .frame(width:20,height:20)
                                    
                            }
                            Button(action:{
                                
                                let TwitterShareString = String("https://twitter.com/intent/tweet?text=Check out this link: &url=\(source)&hashtags=CSCI571NetflixApp")
                                let escapedShareString = TwitterShareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                                let twitterUrl: URL = URL(string: escapedShareString)!
                                debugPrint("Twitter uRL ",twitterUrl)
                                openURL(twitterUrl)
                            }){
                                Image("Twitter")
                                    .resizable()
                                    .foregroundColor(Color.blue)
                                    .frame(width:20,height:20)
                                
                            }

                        }

                    }
                }

            player(videoID:NSMutableAttributedString(string: DetailsVM.movieTVShowTrailer)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                .padding(.leading)
                .padding(.trailing)
         
            ScrollView{
                LazyVStack{
                    VStack(alignment: .leading){
                    
                   
                    Text(DetailsVM.movieTVShowName)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.black)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                     //   .padding(.leading, 20)
                        .padding(.bottom,5)


                
            
            //Year,Genre
            HStack{
                Text(DetailsVM.movieTVShowYear+" | "+DetailsVM.movieTVShowGenre)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)

            }
          //  .padding(.leading,20)
            .padding(.bottom,5)
            //HStack
            
            //Average Rating
                (Text(Image(systemName: "star.fill")).foregroundColor(Color.red) + Text("\(String(format: "%.1f",DetailsVM.movieTVShowRating/2))/5.0"))
                .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
              //  .padding(.leading,20)
                .padding(.bottom,5)
            
            //Description
            LongText(DetailsVM.movieTVShowDescription)
               // .padding(.leading,20)
                .padding(.trailing,5)
            
                if(DetailsVM.castMemberData.count>0){
                Text("Cast & Crew").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                 //   .padding(.leading,20)
                    .padding(.top,7)
                    
                    ScrollView(.horizontal, showsIndicators:false){
                        HStack{
                            ForEach(DetailsVM.castMemberData, id: \.self){ cast in

                                VStack{
                                    RemoteImage(url: cast.actorPic)
                                        //.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .shadow(radius: 1)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
            //                                    .border(Color.white)
                                        .frame(width:90, height:110)
    
    
                                    Text(cast.actorName)
    
                                        .font(.caption)
                                      //  .fontWeight(.heavy)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.center)
                                }
                                   
                            }
                        }
                    }


            } //ScrollView for Cast & Crew
            
            //Reviews List
                if(DetailsVM.reviews.count>0){
                    Text("Reviews").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
//                        .padding(.bottom,5)
//                        .padding(.top,7)
                    
                    ForEach(0..<DetailsVM.reviews.count){ index in
                        NavigationLink(destination: DetailedReview(reviewCard:DetailsVM.reviews[index], movieName: self.DetailsVM.movieTVShowName)){
                            
                            CardView(reviewCard:DetailsVM.reviews[index])
                             //   .padding(.bottom,10)
                        }
                    }
                }

                if(DetailsVM.recommendedMovies.count>0){
            //Recommended Movies
                    if(DetailsVM.isMovie){
                Text("Recommended Movies").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                    .padding(.top,7)
                    }
                    else{
                        Text("Recommended Movies").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                            .padding(.top,7)
                       //     .padding(.leading,20)
                    }
                    ScrollView(.horizontal, showsIndicators:false){
                        HStack{
                            ForEach(0..<DetailsVM.recommendedMovies.count){i in
                               
                                NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: DetailsVM.recommendedMovies[i].movieID, isMovie:DetailsVM.recommendedMovies[i].isMovie, movieTMDBLink: DetailsVM.recommendedMovies[i].TMDBLink))){

                                     
                                    RemoteImage(url: DetailsVM.recommendedMovies[i].moviePoster)
                                           // .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                            .frame(width: 100, height: 150)
                                            .cornerRadius(10)
                                            .padding()

                                }
                            }
                        }
                    } //Scrollview Recommended movies
                }
                }

            }
        } //ScrollView ends
        //}
            .padding(.leading)
            .padding(.trailing)
            .toast(isPresented: self.$showToast) {
                HStack {
                    Text(self.toastMessage)
                }
            }

            .onAppear{
                //self.DetailsVM.fetchDetailPageData()
                if DefaultsStorage.get(key: self.DetailsVM.movieID) != nil {
                    self.isBookMarked = true
                } else {
                    self.isBookMarked = false
                }
            }
        }
    }// body ends
    
    func onBookmark(){
        if self.isBookMarked {
            DefaultsStorage.remove(key: self.DetailsVM.movieID)
            self.isBookMarked = false
            self.toastMessage = "Removing \(self.DetailsVM.movieTVShowName) from Watchlist"
        } else {
            DefaultsStorage.store(key: self.DetailsVM.movieID, movie: MovieTV(
                                    id: (self.DetailsVM.movieID as NSString).integerValue,
                                    movieID: self.DetailsVM.movieID, title: self.DetailsVM.movieTVShowName, imgURL: self.DetailsVM.imgURL, isMovie: self.DetailsVM.isMovie, TMDBLink: self.DetailsVM.movieTMDBLink))
            self.isBookMarked = true
            self.toastMessage = "Adding \(self.DetailsVM.movieTVShowName) to Watchlist"
        }
        self.showToast=true
    }
    
    func showToastMessage(controller: UIViewController, message:String, seconds:Double){
        let alert=UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor=UIColor.black
        alert.view.alpha=0.6
        alert.view.layer.cornerRadius=15
        
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+seconds){
            alert.dismiss(animated: true)
        }
    }
    
    
}

struct Loading: View {
    var body: some View {
        ProgressView("Fetching Data...").progressViewStyle(CircularProgressViewStyle())
    }
}

struct player: UIViewRepresentable{
    var videoID:NSMutableAttributedString
    //@Binding var parentView:View
    func makeUIView(context: Context) -> UIView {
        let otherPlayer=YTPlayerView()//.load(withVideoId: videoID, playerVars: ["playsinline":1])
        otherPlayer.load(withVideoId: videoID.string, playerVars: ["playsinline":1])

        return otherPlayer
        }

        func updateUIView(_ uiView: UIView, context: Context) {
  
        }
}


//extending view for toast
extension View {
    func toast<Content>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View where Content: View {
        Toast(
            isPresented: isPresented,
            presenter: { self },
            content: content
        )
    }
}

//for recommended movies list
struct RecommendedMovieData: Hashable{
    var moviePoster: String
    var movieName: String
    let randomInt = Int.random(in: 1..<1000)
    var movieYear: String
    var movieID: String
    var isMovie: Bool
    var TMDBLink: String
    func hash(into hasher: inout Hasher){
        hasher.combine(movieName+moviePoster+String(randomInt))
    }
}

