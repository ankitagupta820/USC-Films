//
//  HomeVM.swift
//  Netflix
//
//  Created by Ankita Gupta on 18/03/21.
//
import Foundation
import SwiftyJSON
import Alamofire

class HomeVM: ObservableObject{
    
    let host:String = "http://10.25.152.245:4001/"
    var isLoaded: Bool
   
    
    @Published var nowPlayingMovie: [Movie]
    @Published var topRatedMovie: [Movie]
    @Published var popularMovie: [Movie]
    
    @Published var airingToday: [Movie]
    @Published var topRatedTV: [Movie]
    @Published var popularTV: [Movie]

    
    
    init(){
        self.isLoaded=false
        
        self.nowPlayingMovie=[Movie(movieID: "278",title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL", TMDBLink:"Default url", isMovie: true)]
        self.topRatedMovie=[Movie(movieID: "278",title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL",TMDBLink:"Default url", isMovie: true)]
        self.popularMovie=[Movie(movieID: "278",title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL",TMDBLink:"Default url", isMovie: true)]
        
        self.airingToday = [Movie(movieID: "278",title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL",TMDBLink:"Default url", isMovie: false)]
        self.topRatedTV = [Movie(movieID: "278",title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL",TMDBLink:"Default url", isMovie: false)]
        self.popularTV = [Movie(movieID: "278",title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL",TMDBLink:"Default url", isMovie: false)]
        fetchHomePageData()
    }
    
    func fetchHomePageData(){
        
        self.fetchNowPlaying()
        self.fetchTopRated()
        self.fetchPopular()
        
    }
    
    func fetchNowPlaying(){
        
        
        //Movie
        let urlMovie: String = host+"movies/now-playing"
        debugPrint("urlMOvie "+urlMovie)
     
        AF.request(urlMovie, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                debugPrint("Data ",data)
                
                var MoviesArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        movieID: item["id"].stringValue,
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue,
                        TMDBLink: item["TMDBLink"].stringValue,
                        isMovie: true)
                 
                    MoviesArray.append(movieObj)
                }
                self.nowPlayingMovie=MoviesArray
                debugPrint("nowPlaying fetched!")
                
            case .failure(let error):
                print(error)
            }
        }
        
        //TV
        let urlTV: String = host+"tv-series/airing_today"
        AF.request(urlTV, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                
                var MoviesArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        movieID: item["id"].stringValue,
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue,
                        TMDBLink: item["TMDBLink"].stringValue,
                        isMovie: false)
                    MoviesArray.append(movieObj)
                }
                self.airingToday=MoviesArray
                debugPrint("Airing today fetched!")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTopRated(){
        
        //Movie
        let url: String = host+"movies/top-rated"
        AF.request(url, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                
                var topRatedArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        movieID: item["id"].stringValue,
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue,
                        TMDBLink: item["TMDBLink"].stringValue,
                        isMovie: true)
                    topRatedArray.append(movieObj)
                }
                self.topRatedMovie=topRatedArray
                debugPrint("topRatedMovie fetched!")
                
            case .failure(let error):
                print(error)
            }
        }
        
        
        //TV
        let urlTV: String = host+"tv-series/top-rated"
        AF.request(urlTV, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                
                var topRatedArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        movieID: item["id"].stringValue,
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue,
                        TMDBLink: item["TMDBLink"].stringValue,
                        isMovie: false)
                    topRatedArray.append(movieObj)
                }
                self.topRatedTV=topRatedArray
                debugPrint("topRatedTV fetched!")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchPopular(){
        
        //Movie
        let url: String = host+"movies/popular/"
        AF.request(url, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                
                var MoviesArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        movieID: item["id"].stringValue,
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue,
                        TMDBLink: item["TMDBLink"].stringValue,
                        isMovie: true)
                    MoviesArray.append(movieObj)
                }
                self.popularMovie=MoviesArray
                debugPrint("PopularMovie fetched!")
                self.isLoaded=true
                
                
            case .failure(let error):
                print(error)
            }
        }
        
        //TV
        let urlTV: String = host+"tv-series/popular/"
        AF.request(urlTV, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                
                var MoviesArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        movieID: item["id"].stringValue,
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue,
                        TMDBLink: item["TMDBLink"].stringValue,
                        isMovie: false)
                    MoviesArray.append(movieObj)
                }
                self.popularTV=MoviesArray
                debugPrint("PopularTV fetched!")
                self.isLoaded=true
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func formatDate(date: String)-> String{
        
        let dateComponets =  date.split(separator: "-")
        return String(dateComponets[0])
        
    }
    
}


struct Movie: Identifiable{
    var id = UUID()
    var movieID: String
    var title: String
    var year: String
    var imgURL: String
    var TMDBLink:String
    var isMovie: Bool
}
