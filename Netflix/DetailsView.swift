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
   

  //  let movieID: String
   // let videoURL: String
    @State var isBookMarked: Bool = false
    @State var ToastMessage:String = ""
    @State var showToast:Bool = false
    @State var videoId = NSMutableAttributedString(string: "QGnXv7vJkJY")
    @State var averageStarRating: Float = 4.5
    @ObservedObject var DetailsVM: DetailVM
//    videoId = NSMutableAttributedString(string: DetailsVM.movieTVShowTrailer)

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
        
        //VStack{
            VStack{

            }
            .navigationBarTitle("")

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
      //  }
        
       
        
        player(videoID:NSMutableAttributedString(string: DetailsVM.movieTVShowTrailer)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
     
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
            ScrollView{
                LazyVGrid(columns:layout, spacing:10){
                    ForEach(DetailsVM.castMemberData, id: \.self){ cast in
                        VStack{
                            KFImage(URL(string: cast.actorPic))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .shadow(radius: 1)
                                .overlay(Circle().stroke(Color.white, lineWidth: 1))
    //                                    .border(Color.white)
                                .frame(width:90, height:110)
                                

                            Text(cast.actorName)
                                .font(.subheadline)
                        }
                    }
                }
            }

        } //ScrollView for Cast & Crew
        
        //Reviews List
            if(DetailsVM.reviews.count>0){
                Text("Reviews").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                    .padding(.bottom,5)
                    .padding(.top,7)
                
                ForEach(0..<DetailsVM.reviews.count){ index in
                    NavigationLink(destination: DetailedReview(reviewCard:DetailsVM.reviews[index], movieName: self.DetailsVM.movieTVShowName)){
                        
                        CardView(reviewCard:DetailsVM.reviews[index])
                            .padding(.bottom,10)
                    }
                }
            }

            if(DetailsVM.recommendedMovies.count>0){
        //Recommended Movies
                if(DetailsVM.isMovie){
            Text("Recommended Movies").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                .padding(.top,7)
               // .padding(.leading,20)
                }
                else{
                    Text("Recommended Movies").font(.system(size: 25.0, design:.rounded)).fontWeight(.bold)
                        .padding(.top,7)
                   //     .padding(.leading,20)
                }
                ScrollView(.horizontal, showsIndicators:false){
                    HStack{
                        ForEach(0..<DetailsVM.recommendedMovies.count){i in
                           
                            NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: DetailsVM.recommendedMovies[i].movieID, isMovie:DetailsVM.recommendedMovies[i].isMovie))){

                                 
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
                } //Scrollview Recommended movies
            }
            }

        }
    } //ScrollView ends
    //}
        .onAppear{
            self.DetailsVM.fetchDetailPageData()
        }
    }
    


    func onShare(){
        print("Share tapped")
    }
    func onBookmark(){
        DefaultsStorage.toggleBookmark(ticker: self.DetailsVM.movieID, name: DetailsVM.movieTVShowName)
        self.isBookMarked = DefaultsStorage.isBookMarked(ticker: self.DetailsVM.movieID)
       // self.PortfolioVM.fetchPortfolio()
        
        if self.isBookMarked {
            self.ToastMessage = "Adding \(self.DetailsVM.movieID) to Favorites"
            //self.showToastMessage(controller: <#T##UIViewController#>, message: self.ToastMessage, seconds: 0.5)
        }else{
            self.ToastMessage = "Removing \(self.DetailsVM.movieID) from Favorites"
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





//for recommended movies list
struct RecommendedMovieData: Hashable{
    var moviePoster: String
    var movieName: String
    let randomInt = Int.random(in: 1..<1000)
    var movieYear: String
    var movieID: String
    var isMovie: Bool
    func hash(into hasher: inout Hasher){
        hasher.combine(movieName+moviePoster+String(randomInt))
    }
}

