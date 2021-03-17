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
    let ticker: String
   
    
    @Published var movieTVShowName: String
    @Published var movieTVShowYear: String
    @Published var movieTVShowGenre: String
    @Published var movieTVShowDescription:String
    @Published var isLoading: Bool = true
    @Published var castMemberData: [CastHashableArray]
    
    
    init(ticker: String){
        //depends what data is fetched from tmdb
        self.ticker = ticker
        
        movieTVShowName = "Justice League: The Snyder Cut Final"
        movieTVShowYear = String(("2021-03-03").split(separator: "-")[0])
        movieTVShowGenre = "Science Fiction"
        movieTVShowDescription = "Fuelled by his restored faith in humanity and inspired by Superman's selfless act, Bruce Wayne and Diana Prince assemble a team of metahumans consisting of Barry Allen, Arthur Curry and Victor Stone to face the catastrophic threat of Steppenwolf and the Parademons who are on the hunt for three Mother Boxes on Earth."
    
        castMemberData = [
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
//        castMemberData=[
//            CastHashableArray("Henry Cavill","Henry Cavill","https://www.google.com/search?q=Henry+Cavill&sa=X&stick=H4sIAAAAAAAAAONgFuLVT9c3NMwyNDKoNE4zUOLUz9U3MDdItszQEspOttJPy8zJBRNWyYnFJY8YrzFyC7z8cU9Y6gzjpDUnrzEeZeTCok5Ij4vNNa8ks6RSSIVLUArVDg0GKX4uNGvLjTJ2XZp2ji1JUCSdgcElOsxBykjw3lIN1cLv7-21hLjYPYt98pMTcwSzTv2yl_oLFBPm4ghJrMjPy8-tFNx-7M7-b__f2yspcmZaSD6okHprL3j6w9_7illmDhJsCgwaDIYXFHgPZN7jOKDFcICRqWnfikNsLByMAgxWTBqMVUwcLDyLWHk8UvOKKhWcE8syc3ImsDECALO8QpQcAQAA&biw=1440&bih=821&tbm=isch&source=iu&ictx=1&fir=jLg1kRVAr7EC2M%252CxT80m-z0EvEOoM%252C%252Fm%252F070c9h&vet=1&usg=AI4_-kT3PGde6B0apvE19mvXwElwQa4rzQ&ved=2ahUKEwitjJjOubHvAhUSMH0KHbC3BUEQ_B16BAg6EAE#imgrc=jLg1kRVAr7EC2M"),
//            Cast("Jared Leto","Jared Leto","https://www.google.com/search?q=Jared+Leto&sa=X&stick=H4sIAAAAAAAAAONgFuLVT9c3NMwyNDKoNE4zUOLUz9U3MEqrTMrREspOttJPy8zJBRNWyYnFJY8YrzFyC7z8cU9Y6gzjpDUnrzEeZeTCok5Ij4vNNa8ks6RSSIVLUArVDg0GKX4uNGvLjTJ2XZp2ji1JUCSdgcElOsxBykjw3lIN1cLv7-21hLjYPYt98pMTcwSzTv2yl_oLFBPm4ghJrMjPy8-tFNx-7M7-b__f2yspcmZaSD6okHprL3j6w9_7illmDhJsCgwaDIYXFHgPZN7jOKDFcICRqWnfikNsLByMAgxWTBqMVUwcLDyLWLm8EotSUxR8UkvyJ7AxAgCURr1QGgEAAA&biw=1440&bih=821&tbm=isch&source=iu&ictx=1&fir=iaq1TJZWcLrbCM%252C5wYTFdinUZV8IM%252C%252Fm%252F02fybl&vet=1&usg=AI4_-kSUZJEPrTptVpNb6ngA-fTB_2UnrQ&ved=2ahUKEwiY9M_mubHvAhX_IzQIHXYtCS4Q_B16BAg6EAE#imgrc=iaq1TJZWcLrbCM"),
//            Cast("Ray Fisher","Ray Fisher",
//                 "https://www.google.com/search?q=Ray+Fisher&sa=X&stick=H4sIAAAAAAAAAONgFuLVT9c3NMwyNDKoNE4zUOLSz9U3qMgzKTA31RLKTrbST8vMyQUTVsmJxSWPGK8xcgu8_HFPWOoM46Q1J68xHmXkwqJOSI-LzTWvJLOkUkiFS1AK1RINBil-LjR7y40ydl2ado4tSVAknYHBJTrMQcpI8N5SDdXC7-_ttYS42D2LffKTE3MEs079spf6CxQT5uIISazIz8vPrRTcfuzO_m__39srKXJmWkg-qJB6ay94-sPf-4pZZg4SbAoMGgyGFxR4D2Te4zigxXCAkalp34pDbCwcjAIMVkwajFVMHCw8i1i5ghIrFdwyizNSiyawMQIAMs7ughsBAAA&biw=1440&bih=821&tbm=isch&source=iu&ictx=1&fir=0wkS-Hq2EkuoDM%252Cc96tN-iVDBE7bM%252C%252Fm%252F0xn4p75&vet=1&usg=AI4_-kTMh1cVnsk00R9dp3DS3J5NuWTOwA&ved=2ahUKEwiopJiAurHvAhWYGDQIHeQWCgoQ_B16BAhEEAE#imgrc=0wkS-Hq2EkuoDM"),
//            Cast("Gal Gadot", "Gal Gadot",
//                 "https://www.google.com/search?q=Gal+Gadot&sa=X&stick=H4sIAAAAAAAAAONgFuLVT9c3NMwyNDKoNE4zUOLUz9U3sKhMT6nUEspOttJPy8zJBRNWyYnFJY8YrzFyC7z8cU9Y6gzjpDUnrzEeZeTCok5Ij4vNNa8ks6RSSIVLUArVDg0GKX4uNGvLjTJ2XZp2ji1JUCSdgcElOsxBykjw3lIN1cLv7-21hLjYPYt98pMTcwSzTv2yl_oLFBPm4ghJrMjPy8-tFNx-7M7-b__f2yspcmZaSD6okHprL3j6w9_7illmDhJsCgwaDIYXFHgPZN7jOKDFcICRqWnfikNsLByMAgxWTBqMVUwcLDyLWDndE3MU3BNT8ksmsDECACNfBeQZAQAA&biw=1440&bih=821&tbm=isch&source=iu&ictx=1&fir=RdfFKYXt02jXeM%252CFKp_jnvkdHxlvM%252C%252Fm%252F08ygdy&vet=1&usg=AI4_-kSyGnzNXgc6TUDsNB9EQet4FiJWww&ved=2ahUKEwjp4r2PurHvAhV6JzQIHeOUCf0Q_B16BAg1EAE#imgrc=RdfFKYXt02jXeM")
//
//
//        ]
    }
    
    func fetchCastData() {
        self.isLoading=false
        castMemberData = [
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
       
        //backend call for cast members
        //castMemberData= backend call
    }
    
 
}

struct castHashableArray: Hashable{

    var actorName: String
    var actorPic: String
    let randomInt = Int.random(in: 1..<1000)
    func hash(into hasher: inout Hasher) {
        hasher.combine(actorName+actorPic+String(randomInt))
    }

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

