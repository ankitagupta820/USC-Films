//
//  DetailsVM.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/13/21.
//

import Foundation
import SwiftyJSON
import Alamofire

class DetailVM: ObservableObject {
    
    //subject to change
    let movieID: String
    let isMovie: Bool

    let movieTMDBLink: String

    let host:String = global.server
    var isLoadedArray: [Bool] = [false, false, false, false]
    
    @Published var movieTVShowName: String
    @Published var movieTVShowYear: String
    @Published var movieTVShowGenre: String
    @Published var movieTVShowDescription:String
    @Published var movieTVShowRating: Float
    @Published var isLoaded: Bool = false
    
    //@Published var isMovie: Bool = true
    @Published var castMemberData: [CastHashableArray]
    @Published var reviews: [ReviewCard]
    @Published var recommendedMovies: [RecommendedMovieData]
    @Published var movieTVShowTrailer: String
    @Published var imgURL: String
  //  @Published var movieAvgRating: Float
    
    init(movieID: String, isMovie: Bool, movieTMDBLink: String){
        
        //depends what data is fetched from tmdb
        self.movieID = movieID
       // print("Init called ",self.movieID)
        
        self.movieTVShowName = "DefaultMovieName"
        self.movieTVShowYear = String(("2021-03-03").split(separator: "-")[0])
        self.movieTVShowGenre = "Science Fiction"
        self.movieTVShowDescription = "Fuelled by his restored faith in humanity and inspired by Superman's selfless act, Bruce Wayne and Diana Prince assemble a team of metahumans consisting of Barry Allen, Arthur Curry and Victor Stone to face the catastrophic threat of Steppenwolf and the Parademons who are on the hunt for three Mother Boxes on Earth."

        self.movieTVShowRating = 3.5

        self.castMemberData = [
            CastHashableArray(actorName: "Henry Cavill",actorPic: "https://www.themoviedb.org/t/p/w276_and_h350_face/485V2gC6w1O9D96KUtKPyJpgm2j.jpg"),
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
        self.isMovie=isMovie
        self.reviews=[]
        self.recommendedMovies=[]
        self.movieTVShowTrailer = "qxKqMJxw6vc"

        self.movieTMDBLink = movieTMDBLink

        self.imgURL = ""

        //fetchDetailPageData()
    }
    
    func checkIsLoaded() -> Bool{
        for isLoaded in self.isLoadedArray {
            if(!isLoaded) {
                return false;
            }
        }
        return true;
    }
    
    
    func fetchDetailPageData(){
        self.fetchBasicDetails()
        //self.fetchCastMembers()
        self.fetchCastMembers()
        self.fetchReviews()
        self.fetchRecommenedMovies()
        
    }
    func fetchRecommenedMovies(){
        var url : String=""
       // let movieID=278
        var count: Int = 0
        if(isMovie){
            url = host+"movies/recommended?movieId="+self.movieID
        }
        else{
            url = host+"tv-series/recommended?tvId="+self.movieID
        }
        
        AF.request(url, encoding:JSONEncoding.default).responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                //print("Data ",data)
                var recoMovies: [RecommendedMovieData] = []
                for item in data.arrayValue {
                    if(count<10){
                        let recoMovieObj = RecommendedMovieData(
                           // reviewTitle: item[""],
                            moviePoster: item["imageURL"].stringValue,
                            movieName: item["title"].stringValue,
                            movieYear: self.formatDate(date: item["releaseDate"].stringValue),
                            movieID: item["id"].stringValue,
                            isMovie: self.isMovie,
                            TMDBLink: item["TMDBLink"].stringValue
                            
                           
                        )

                        recoMovies.append(recoMovieObj)
                        count+=1
                    }
                }
                self.recommendedMovies=recoMovies
                debugPrint("Recos fetched")
                self.isLoadedArray[3] = true
                self.isLoaded = self.checkIsLoaded()
            case .failure(let error):
                print(error)
                
            }
        
    }
    }
    func fetchReviews(){
        var url : String=""
        if(isMovie){
            url = host+"movies/reviews?movieId="+self.movieID
        }
        else{
            url = host+"tv-series/reviews?tvId="+self.movieID
        }

        AF.request(url, encoding:JSONEncoding.default).responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]["results"]
                var count=0
                
                var reviews: [ReviewCard] = []
                for item in data.arrayValue {
                    if(count<3){

                        let reviewObj = ReviewCard(
                            rating: item["author_details"]["rating"].floatValue,
                            reviewAuth: item["author_details"]["username"].stringValue,
                            reviewDate: item["created_at"].stringValue,
                            reviewText: item["content"].stringValue
                           
                           
                        )
                            count+=1
                        reviews.append(reviewObj)
                    }
                }
                self.reviews=reviews
                self.isLoadedArray[2] = true
                self.isLoaded = self.checkIsLoaded()
                //debugPrint("Reviews fetched")
            case .failure(let error):
                print(error)
                
            }
            
        }

    }
    func fetchCastMembers(){
        var url : String=""
      //  let movieID=278
        if(isMovie){
            url = host+"movies/cast?movieId="+self.movieID
        }
        else{
            url = host+"tv-series/cast?tvId="+self.movieID
        }
      //  url="http://10.25.152.245:4001/movies/cast?movieId=278"
        debugPrint(url)
        AF.request(url, encoding:JSONEncoding.default).responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                var count=0
                
                var castMembers: [CastHashableArray] = []
                
                for item in data.arrayValue {
                    if(count<10){
                        let castObj = CastHashableArray(
                            actorName: item["name"].stringValue,
                            actorPic: item["imageURL"].stringValue
                        )

                        castMembers.append(castObj)
                        count+=1
                    }
                }
                self.castMemberData=castMembers
                self.isLoadedArray[1] = true
                self.isLoaded = self.checkIsLoaded()
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
    func fetchBasicDetails(){
        var url : String=""
       // let movieID=278
        if(isMovie){
            url = host+"movies/details?movieId="+self.movieID
        }
        else{
            url = host+"tv-series/details?tvId="+self.movieID
        }

        AF.request(url, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                debugPrint("switch ")
                let json = JSON(value)
                let data = json["data"]
                
                self.movieTVShowName = data["title"].stringValue
                if(self.isMovie){
                    
                        self.movieTVShowYear = self.formatDate(date: data["release_date"].stringValue)
                        let dateComponents =  data["release_date"].stringValue.split(separator: "-")
                        if dateComponents.count == 0 {
                            self.movieTVShowYear = "Not Available"
                        }
                }
                else{
                   
                        self.movieTVShowYear = self.formatDate(date: data["first_air_date"].stringValue)
                        let dateComponents =  data["first_air_date"].stringValue.split(separator: "-")
                        if dateComponents.count == 0 {
                            self.movieTVShowYear = "Not Available"
                        }

                    
                }
                var genre = ""
                for g_item in data["genres"].arrayValue {
                    genre += g_item.stringValue + ", "
                }
                genre=String(genre.dropLast(2))
                print("Genre "+genre)
                self.movieTVShowGenre = genre
                
                self.movieTVShowDescription=data["overview"].stringValue
                
                self.movieTVShowRating=data["vote_average"].floatValue
                print("MovieTVShow Rating" + String(self.movieTVShowRating))
                
                self.movieTVShowTrailer = data["video_details"]["video_id"].stringValue

                self.imgURL = data["imageURL"].stringValue
                print("image url: " + self.imgURL)
                self.isLoadedArray[0] = true
                self.isLoaded = self.checkIsLoaded()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func formatDate(date: String)-> String{
        
        let dateComponets =  date.split(separator: "-")
        if dateComponets.count == 0 {
            return "Not Available"
        }
        return String(dateComponets[0])
        
    }
    
    
    
    //function to convert html to plain text
    func decodeString(encodedString:String) -> NSAttributedString?
    {

        let encodedData = encodedString.data(using: String.Encoding.utf8)!
        do {
           return try NSAttributedString(data: encodedData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
          
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}

struct castHashableArray: Identifiable{
    var id=UUID()
    var actorName: String
    var actorPic: String
   
    
}

struct Cast{
    var character: String
    var actorName: String
    var actorPicture: String
    
    init(_ character: String, _ actorName: String, _ actorPicture: String) {
        self.character = character
        self.actorName = actorName
        self.actorPicture = actorPicture
    }
}
