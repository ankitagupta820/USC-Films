//
//  WatchListVM.swift
//  Netflix
//
//  Created by 潘一帆 on 2021/3/19.
//

import Foundation
class WatchListVM: ObservableObject, Identifiable {
    @Published var watchList: [MovieTV]
    
    init(){
        //depends what data is fetched from tmdb
        watchList = [MovieTV( id: 527774, imgURL: "https://image.tmdb.org/t/p/w500//lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg"),
                     MovieTV( id: 793723, imgURL: "https://image.tmdb.org/t/p/w500//fFRq98cW9lTo6di2o4lK1qUAWaN.jpg"),
                     MovieTV( id: 587996, imgURL: "https://image.tmdb.org/t/p/w500//dWSnsAGTfc8U27bWsy2RfwZs0Bs.jpg"),
                     MovieTV( id: 587807, imgURL: "https://image.tmdb.org/t/p/w500//6KErczPBROQty7QoIsaa6wJYXZi.jpg"),
                     MovieTV( id: 458576, imgURL: "https://image.tmdb.org/t/p/w500//1UCOF11QCw8kcqvce8LKOO6pimh.jpg"),
                     MovieTV( id: 464052, imgURL: "https://image.tmdb.org/t/p/w500//8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg")
                     
                     
        ]
       
    }
}

struct MovieTV: Identifiable{
    var id : NSInteger
    var imgURL: String
}
