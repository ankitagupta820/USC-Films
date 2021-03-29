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
    
    init() {
        watchList = []
        self.refresh()
    }
    
    func refresh() {
        watchList = DefaultsStorage.getMoviesList()
    }
}

struct MovieTV: Identifiable, Encodable, Decodable{
    var id : NSInteger
    var movieID: String
    var title : String
    var imgURL : String
    var isMovie: Bool
    var TMDBLink: String
}
