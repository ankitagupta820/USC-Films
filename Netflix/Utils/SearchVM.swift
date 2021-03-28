//
//  SearchVM.swift
//  Netflix
//
//  Created by 潘一帆 on 2021/3/24.
//

import Foundation
import SwiftyJSON
import Alamofire
class SearchVM: ObservableObject {
    @Published var searchResult: [Movie] = []
    @Published var isLoaded = false
    let host: String = global.server
//    let input: String
//    init(input: String) {
//        self.input = input
//        self.searchResult = []
//    }
    
    func fetchResults(input: String){
        //print("search: " + input)
        let url: String = host + "search/all?query=" + input
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, encoding:JSONEncoding.default).responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["data"]
                var temp = [Movie]()
                for item in data.arrayValue {
                    let movie = Movie(
                       // reviewTitle: item[""],
                        movieID: item["id"].stringValue,
                        title: item["title"].stringValue,
                        year: String(item["releaseDate"].stringValue.split(separator: "-")[0]),
                        imgURL: item["imageURL"].stringValue,
                        TMDBLink: item["TMDBLink"].stringValue,
                        isMovie: item["mediaType"].stringValue == "movie",
                        vote: item["voteAverage"].doubleValue
                       
                    )
                    //print("search result: " + movie.title)
                    temp.append(movie)
                }
                self.searchResult = temp
                self.isLoaded = true
            case .failure(let error):
                print(error)
            }
        }
    }
}
