//
//  WatchListVM.swift
//  Netflix
//
//  Created by 潘一帆 on 2021/3/19.
//

import Foundation
class WatchListVM: ObservableObject, Identifiable {
    @Published var watchList: [MovieTV]
    @Published var currentMovieTV: MovieTV?
    
    init(){
        //depends what data is fetched from tmdb
        watchList = [MovieTV( id: 527774, movieID: "278", title: "Raya and the Last Dragon", imgURL: "https://image.tmdb.org/t/p/w500//lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg"),
                     MovieTV( id: 793723, movieID: "278", title: "Sentinelle", imgURL: "https://image.tmdb.org/t/p/w500//fFRq98cW9lTo6di2o4lK1qUAWaN.jpg"),
                     MovieTV( id: 587996, movieID: "278", title: "Below Zero", imgURL: "https://image.tmdb.org/t/p/w500//dWSnsAGTfc8U27bWsy2RfwZs0Bs.jpg"),
                     MovieTV( id: 587807, movieID: "278",title: "Tom & Jerry", imgURL: "https://image.tmdb.org/t/p/w500//6KErczPBROQty7QoIsaa6wJYXZi.jpg"),
                     MovieTV( id: 458576, movieID: "278", title: "Zack Snyder's Justice League", imgURL: "https://image.tmdb.org/t/p/w500//tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg"),
                     MovieTV( id: 791373, movieID: "278", title: "Coming 2 America", imgURL: "https://image.tmdb.org/t/p/w500//nWBPLkqNApY5pgrJFMiI9joSI30.jpg"),
                     MovieTV( id: 581389, movieID: "278", title: "Space Sweepers", imgURL: "https://image.tmdb.org/t/p/w500//qiUesQForGW872kIC0Crqx3vAr0.jpg"),
                     MovieTV( id: 522444, movieID: "278",title: "Black Water: Abyss", imgURL: "https://image.tmdb.org/t/p/w500//95S6PinQIvVe4uJAd82a2iGZ0rA.jpg"),
                     MovieTV( id: 775996, movieID: "278",title: "Outside the Wire", imgURL: "https://image.tmdb.org/t/p/w500//6XYLiMxHAaCsoyrVo38LBWMw2p8.jpg")
        ]
       
    }
}

struct MovieTV: Identifiable{
    var id : NSInteger
    var movieID: String
    var title : String
    var imgURL : String
}
