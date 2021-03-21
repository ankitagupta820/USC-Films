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
    
    var host:String
    var isLoaded: Bool
    
    @Published var nowPlayingMovie: [Movie]
    @Published var topRatedMovie: [Movie]
    @Published var popularMovie: [Movie]
    
    @Published var airingToday: [Movie]
    @Published var topRatedTV: [Movie]
    @Published var popularTV: [Movie]
    
    
    init(){
        self.host = Constants.host
        self.isLoaded=false
        
        self.nowPlayingMovie=[Constants.SampleMovie]
        self.topRatedMovie=[Constants.SampleMovie]
        self.popularMovie=[Constants.SampleMovie]
        
        self.airingToday = [Constants.SampleMovie]
        self.topRatedTV = [Constants.SampleMovie]
        self.popularTV = [Constants.SampleMovie]
        
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
        AF.request(urlMovie, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            
            case .success(let value):
                let json = JSON(value)
                self.nowPlayingMovie = self.processResponse(json: json)
                debugPrint("NowPlaying fetched!")
                
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
                self.airingToday=self.processResponse(json: json)
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
                self.topRatedMovie=self.processResponse(json: json)
                debugPrint("TopRatedMovie fetched!")
        
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
                self.topRatedTV=self.processResponse(json: json)
                debugPrint("TopRatedTV fetched!")
                
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
                self.popularMovie=self.processResponse(json: json)
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
                self.popularTV=self.processResponse(json: json)
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
    
    func processResponse(json: JSON) -> [Movie]{
        
        let data = json["data"]
        var MoviesArray: [Movie] = []
        for item in data.arrayValue {
            let movieObj = Movie(
                category: item[Constants.category].stringValue,
                movieID: item[Constants.movieID].stringValue,
                title: item[Constants.title].stringValue,
                year: self.formatDate(date: item[Constants.releaseDate].stringValue),
                imgURL: item[Constants.imgURL].stringValue)
            MoviesArray.append(movieObj)
        }
        return MoviesArray
    }
    
}


struct Movie: Identifiable{
    var id = UUID()
    var category: String
    var movieID: String
    var title: String
    var year: String
    var imgURL: String
    
}

