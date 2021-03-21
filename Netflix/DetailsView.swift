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
import Kingfisher
//import Toast

//load this page only when data is fetched
struct DetailsView: View {
   
    @ObservedObject var DetailsVM: DetailVM
   
    @State var isBookMarked: Bool = false
    @State var ToastMessage:String = ""
    @State var showToast:Bool = false
    @State var videoId = NSMutableAttributedString(string: "QGnXv7vJkJY")
    @State var averageStarRating: Float = 4.5
  
    
//    @State var castMember: [CastHashableArray] =
//        [CastHashableArray(actorName: "Henry Cavill",actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"),
//        CastHashableArray(actorName:"Amy Adams",actorPic:"https://www.themoviedb.org/t/p/w276_and_h350_face/1h2r2VTpoFb5QefAaBYYQgQzL9z.jpg"),
//        CastHashableArray(actorName:"Ray Fisher",
//                          actorPic:"https://w ww.themoviedb.org/t/p/w276_and_h350_face/310snvA05xDOQZDn2fJSp242GHw.jpg"),
//        CastHashableArray(actorName:"Gal Gadot",
//                          actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/1uFvXHf18NBnlwsJHVaikLXwp9Y.jpg"),
//        CastHashableArray(actorName:"Gal Gadot",
//                          actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/1uFvXHf18NBnlwsJHVaikLXwp9Y.jpg"),
//        CastHashableArray(actorName:"Gal Gadot",
//                          actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/1uFvXHf18NBnlwsJHVaikLXwp9Y.jpg")
//    ]
    
//    @State var Reviews: [ReviewCard] = [ReviewCard(rating: 5, reviewAuth: "DorothyZ", reviewDate: "2021/03/14", reviewText:"This is a treat to all DC fans. Spellbinding graphics, gripping storyline, wonderful performances."),
//                                    ReviewCard(rating: 4, reviewAuth: "CathyK", reviewDate: "2021/03/15", reviewText:"Simply amazed. Must-watch"),
//                                    ReviewCard(rating: 5, reviewAuth: "DorothyZ", reviewDate: "2021/03/14", reviewText:"This is a treat to all DC fans. Spellbinding graphics, gripping storyline, wonderful performances")
//    ]
    
//    @State var RecommendedMovies: [RecommendedMovieData] = [
//        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", movieName: "Wonder Woman", movieYear: "2020-04-14"),
//        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020-04-14"),
//        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020-04-14"),
//        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020"),
//        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020"),
//        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020"),
//        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020")
//
//    ]
    var body: some View{
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
        VStack{
            VStack{
                
            }
            .navigationTitle("")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        Button(action:{
                            self.onBookmark()
                        }){
                            Image(systemName: self.isBookMarked == true ? "plus.circle.fill" : "plus.circle")
                        }
                        .padding()
                        Button(action:{
                            self.onShare()
                        }){
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                    
                }
            }
        }
        player(videoID:$videoId).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
        ScrollView{
            LazyVStack{

        VStack(alignment: .leading){
        //    HStack{
                Text(DetailsVM.movieTVShowName)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.black)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                 //   .padding(.leading, 20)
                    .padding(.bottom,5)

//                Button(action:{
//                    self.onBookmark()
//                }){
//                    Image(systemName: self.isBookMarked == true ? "plus.circle.fill" : "plus.circle")
//
//                    }
//
//                .padding(.trailing,5)
//
//                Button(action: {
//                        self.onShare()
//                    }) {
//                        Image(systemName: "shield")
//                    }
           // } //HStack moviename, buttons
            
        
        //Year,Genre
        HStack{
            Text(DetailsVM.movieTVShowYear+" | "+DetailsVM.movieTVShowGenre)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)

        }
      //  .padding(.leading,20)
        .padding(.bottom,5)
        //HStack
        
        //Average Rating
            (Text(Image(systemName: "star.fill")).foregroundColor(Color.red) + Text("\(String(format: "%.1f",DetailsVM.movieTVShowRating/2))/5"))
            .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
          //  .padding(.leading,20)
            .padding(.bottom,5)
        
        //Description
        LongText(DetailsVM.movieTVShowDescription)
           // .padding(.leading,20)
            .padding(.trailing,5)
        
        Text("Cast & Crew").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
         //   .padding(.leading,20)
            .padding(.top,5)
        ScrollView{
            LazyVGrid(columns:layout, spacing:10){
                ForEach(0..<DetailsVM.castMemberData.count){ i in
                    VStack{
                        KFImage(URL(string: DetailsVM.castMemberData[i].actorPic))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
//                                    .border(Color.white)
                            .frame(width:90, height:110)
                            

                        Text(DetailsVM.castMemberData[i].actorName)
                            .font(.subheadline)
                    }
                }
            }

        } //ScrollView for Cast & Crew
        
        //Reviews List
            if(DetailsVM.reviews.count>0){
                Text("Reviews").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                   // .padding(.leading,20)
                    .padding(.bottom,5)
    //            if(DetailsVM.reviews.count==0){
    //                Text("No Reviews found")
    //                    .font(.caption)
    //
    //            }

                ForEach(0..<DetailsVM.reviews.count){ index in
                    NavigationLink(destination: DetailedReview(reviewCard:DetailsVM.reviews[index])){
                     //   ExDivider()
                        
                        CardView(reviewCard:DetailsVM.reviews[index])
                            .padding(.bottom,10)
                           // .padding(.leading, 20)
                    }
                }
            }

            if(DetailsVM.recommendedMovies.count>0){
        //Recommended Movies
            Text("Recommended Movies").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
           //     .padding(.leading,20)
                
                ScrollView(.horizontal, showsIndicators:false){
                    HStack{
                        ForEach(0..<DetailsVM.recommendedMovies.count){i in
                           
                            NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: DetailsVM.recommendedMovies[i].movieID, category: DetailsVM.movieTVcategory, videoURL: DetailsVM.movieTVvideoURL))){

                                 
                                    KFImage(URL(string: DetailsVM.recommendedMovies[i].moviePoster))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                        .frame(width: 100, height: 150)
                                        .cornerRadius(10)
                                        .padding()

                            }
                        }
                    }
                   // .padding(.leading,20)
                } //Scrollview Recommended movies
            }
            }

        }
    }
        .onAppear{self.DetailsVM.fetchDetailPageData()}
    }
    


    func onShare(){
        print("Share tapped")
    }
    func onBookmark(){
        DefaultsStorage.toggleBookmark(ticker: DetailsVM.movieID, name: DetailsVM.movieTVShowName)
        self.isBookMarked = DefaultsStorage.isBookMarked(ticker: DetailsVM.movieID)
       // self.PortfolioVM.fetchPortfolio()
        
        if self.isBookMarked {
            self.ToastMessage = "Adding \(DetailsVM.movieID) to Favorites"
            //self.showToastMessage(controller: <#T##UIViewController#>, message: self.ToastMessage, seconds: 0.5)
        }else{
            self.ToastMessage = "Removing \(DetailsVM.movieID) from Favorites"
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
struct player: UIViewRepresentable{
    @Binding var videoID:NSMutableAttributedString
    //@Binding var parentView:View
    func makeUIView(context: Context) -> UIView {
        let otherPlayer=YTPlayerView()//.load(withVideoId: videoID, playerVars: ["playsinline":1])
        otherPlayer.load(withVideoId: videoID.string, playerVars: ["playsinline":1])

        return otherPlayer
        }

        func updateUIView(_ uiView: UIView, context: Context) {
  
        }
}





//for recommended movies list
struct RecommendedMovieData: Hashable{
    var moviePoster: String
    var movieName: String
    let randomInt = Int.random(in: 1..<1000)
    var movieYear: String
    var movieID: String
    func hash(into hasher: inout Hasher){
        hasher.combine(movieName+moviePoster+String(randomInt))
    }
}

