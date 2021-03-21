//
//  Constants.swift
//  Netflix
//
//  Created by Ankita Gupta on 21/03/21.
//

import Foundation

struct Constants{
    
   static let host:String = "http://localhost:4001/"
    
    //HomeVM
    static let movieID: String = "id"
    static let title: String="title"
    static let releaseDate: String = "releaseDate"
    static let imgURL: String = "imageURL"
    static let category: String = "category"
    
    //HomeView
    static let SampleMovie: Movie = Movie(category: "DefaultCategory", movieID: "DefaultmovieID", title: "DefaultTitle", year:"DefaultYear", imgURL: "defaultURL")
    static let TSURL1: String = "https://twitter.com/intent/tweet?text=Check out this link: &url="
    static let TSURL2: String = "&hashtags=CSCI571USCFilms"
    static let FSURL: String = "https://www.facebook.com/sharer/sharer.php?u="
    
}
