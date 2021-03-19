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
//import Toast

//load this page only when data is fetched
struct DetailsView: View {
   

    let movieID: String
    let videoURL: String
    @State var isBookMarked: Bool = false
    @State var ToastMessage:String = ""
    @State var showToast:Bool = false
    @State var videoId = NSMutableAttributedString(string: "QGnXv7vJkJY")
    @State var averageStarRating: Float = 4.5
    @ObservedObject var DetailsVM: DetailVM
    
    @State var castMember: [CastHashableArray] =
        [CastHashableArray(actorName: "Henry Cavill",actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"),
        CastHashableArray(actorName:"Amy Adams",actorPic:"https://www.themoviedb.org/t/p/w276_and_h350_face/1h2r2VTpoFb5QefAaBYYQgQzL9z.jpg"),
        CastHashableArray(actorName:"Ray Fisher",
                          actorPic:"https://www.themoviedb.org/t/p/w276_and_h350_face/310snvA05xDOQZDn2fJSp242GHw.jpg"),
        CastHashableArray(actorName:"Gal Gadot",
                          actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/1uFvXHf18NBnlwsJHVaikLXwp9Y.jpg"),
        CastHashableArray(actorName:"Gal Gadot",
                          actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/1uFvXHf18NBnlwsJHVaikLXwp9Y.jpg"),
        CastHashableArray(actorName:"Gal Gadot",
                          actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/1uFvXHf18NBnlwsJHVaikLXwp9Y.jpg")
    ]
    
    @State var Reviews: [ReviewCard] = [ReviewCard(reviewTitle: "Amazing Superhero Movie", rating: 5, reviewAuth: "DorothyZ", reviewDate: "2021/03/14", reviewText:"This is a treat to all DC fans. Spellbinding graphics, gripping storyline, wonderful performances."),
                                    ReviewCard(reviewTitle: "Treat for DC Fans", rating: 4, reviewAuth: "CathyK", reviewDate: "2021/03/15", reviewText:"Simply amazed. Must-watch"),
                                    ReviewCard(reviewTitle: "Amazing Superhero Movie", rating: 5, reviewAuth: "DorothyZ", reviewDate: "2021/03/14", reviewText:"This is a treat to all DC fans. Spellbinding graphics, gripping storyline, wonderful performances")
    ]
    
    @State var RecommendedMovies: [RecommendedMovieData] = [
        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", movieName: "Wonder Woman", movieYear: "2020"),
        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020"),
        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020"),
        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020"),
        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020"),
        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020"),
        RecommendedMovieData(moviePoster: "https://www.themoviedb.org/t/p/w440_and_h660_face/yYMG2uT87auGztI9aKVzBB2pHvK.jpg", movieName: "Batman", movieYear: "2020")
        
    ]
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
        player(videoID:$videoId).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
        ScrollView{
            LazyVStack{
        VStack(alignment: .leading){
            HStack{
                Text(DetailsVM.movieTVShowName)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.black)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 20)
                    .padding(.bottom,5)

                Button(action:{
                    self.onBookmark()
                }){
                    Image(systemName: self.isBookMarked == true ? "plus.circle.fill" : "plus.circle")

                    }

                .padding(.trailing,5)

                Button(action: {
                        self.onShare()
                    }) {
                        Image(systemName: "shield")
                    }
            } //HStack moviename, buttons
            
        
        //Year,Genre
        HStack{
            Text(DetailsVM.movieTVShowYear+" | "+DetailsVM.movieTVShowGenre)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)

        }
        .padding(.leading,20)
        .padding(.bottom,5)
        //HStack
        
        //Average Rating
        (Text(Image(systemName: "star.fill")).foregroundColor(Color.red) + Text("\(String(format: "%.1f",self.averageStarRating))/5"))
            .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading,20)
            .padding(.bottom,5)
        
        //Description
        LongText(DetailsVM.movieTVShowDescription)
            .padding(.leading,20)
            .padding(.trailing,5)
        
        Text("Cast & Crew")
            .font(.title2)
            .padding(.leading,20)
            .padding(.top,5)
        ScrollView{
            LazyVGrid(columns:layout, spacing:10){
                ForEach(0..<castMember.count){ i in
                    VStack{
                        RemoteImage(url: castMember[i].actorPic)
                            .clipShape(Circle())
                            .shadow(radius: 1)
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
//                                    .border(Color.white)
                            .frame(width:70, height:100)

                        Text(castMember[i].actorName)
                            .font(.subheadline)
                    }
                }
            }

        } //ScrollView for Cast & Crew
        
        //Reviews List
            Text("Reviews")
                .font(.title2)
                .padding(.leading,20)
                .padding(.bottom,5)

                ForEach(0..<Reviews.count){ index in
                    ExDivider()
                    CardView(reviewCard:Reviews[index])
                        .padding(.bottom,10)
                        .padding(.leading, 20)

                }
//        Text("Reviews")
//            .font(.title2)
//            .padding(.leading,20)
//            .padding(.bottom,3)
//
//            ForEach(0..<Reviews.count){ index in
//                ExDivider()
//                CardView(reviewCard:Reviews[index])
//                    .padding(.bottom,5)
//
//
//            }
        //Recommended Movies
            Text("Recommended Movies")
                .font(.title2)
                .padding(.leading,20)
                .padding(.bottom, -25)
                ScrollView(.horizontal, showsIndicators:false){
                    HStack{
                        ForEach(0..<self.RecommendedMovies.count){i in
                            let jsonURL = RecommendedMovies[i].moviePoster

                            //print(jsonURL)
                            VStack(spacing:0){
                                    RemoteImage(url: jsonURL)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:70, height: 200, alignment: .center)
                                        .padding(.trailing,15)
                                        .onTapGesture(count: 1){
                                            print("Single tapped!")
                                            //code to navigate to DetailScreen here
                                        }
                                Text(RecommendedMovies[i].movieName+" ("+RecommendedMovies[i].movieYear+") ")
                                    .font(.caption)
                                    .padding(.top,-10)

                            }


                        }

                    }
                    .padding(.leading,20)
                } //Scrollview Recommended movies
        
            }

        }
    }
    }
    


    func onShare(){
        print("Share tapped")
    }
    func onBookmark(){
        DefaultsStorage.toggleBookmark(ticker: self.movieID, name: DetailsVM.movieTVShowName)
        self.isBookMarked = DefaultsStorage.isBookMarked(ticker: self.movieID)
       // self.PortfolioVM.fetchPortfolio()
        
        if self.isBookMarked {
            self.ToastMessage = "Adding \(self.movieID) to Favorites"
            //self.showToastMessage(controller: <#T##UIViewController#>, message: self.ToastMessage, seconds: 0.5)
        }else{
            self.ToastMessage = "Removing \(self.movieID) from Favorites"
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


//for expandable card
struct LongText: View {

    /* Indicates whether the user want to see all the text or not. */
    @State private var expanded: Bool = false

    /* Indicates whether the text has been truncated in its display. */
    @State private var truncated: Bool = false

    private var text: String

    init(_ text: String) {
        self.text = text
    }

    private func determineTruncation(_ geometry: GeometryProxy) {
        // Calculate the bounding box we'd need to render the
        // text given the width from the GeometryReader.
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(self.text)
                .font(.system(size: 16))
                .lineLimit(self.expanded ? nil : 3)
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.determineTruncation(geometry)
                    }
                })

            if self.truncated {
                self.toggleButton
            }
        }
    }

    var toggleButton: some View {
        Button(action: { self.expanded.toggle() }) {
            Text(self.expanded ? "Show less" : "Show more")
                .font(.body)
                .foregroundColor(Color.red)
               
        }
    }

}


//for recommended movies list
struct RecommendedMovieData: Hashable{
    var moviePoster: String
    var movieName: String
    let randomInt = Int.random(in: 1..<1000)
    var movieYear: String
    func hash(into hasher: inout Hasher){
        hasher.combine(movieName+moviePoster+String(randomInt))
    }
}



