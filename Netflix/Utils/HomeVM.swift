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
    
    let host:String = "http://localhost:4000/"
    var isLoaded: Bool
    @Published var nowPlaying: [Movie]
    @Published var topRated: [Movie]
    @Published var popular: [Movie]
    
    
    init(){
        self.isLoaded=false
        self.nowPlaying=[Movie(title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL")]
        self.topRated=[Movie(title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL")]
        self.popular=[Movie(title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL")]
        fetchHomePageData()
    }
    
    func fetchHomePageData(){
        
        self.fetchNowPlaying()
        self.fetchTopRated()
        self.fetchPopular()
        
    }
    
    func fetchNowPlaying(){
        
        
        let url: String = host+"movies/now-playing"
        AF.request(url, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]

                
                var MoviesArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue)
                    MoviesArray.append(movieObj)
                }
                self.nowPlaying=MoviesArray
                debugPrint("nowPlaying fetched!")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTopRated(){
        
        let url: String = host+"movies/top-rated"
        AF.request(url, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                
                var topRatedArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue)
                    topRatedArray.append(movieObj)
                }
                self.topRated=topRatedArray
                debugPrint("topRated fetched!")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchPopular(){
        
        let url: String = host+"movies/popular/"
        AF.request(url, encoding:JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                
                var MoviesArray: [Movie] = []
                for item in data.arrayValue {
                    let movieObj = Movie(
                        title: item["title"].stringValue,
                        year: self.formatDate(date: item["releaseDate"].stringValue),
                        imgURL: item["imageURL"].stringValue)
                    MoviesArray.append(movieObj)
                }
                self.popular=MoviesArray
                debugPrint("Popular fetched!")
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
    var title: String
    var year: String
    var imgURL: String
    
}
