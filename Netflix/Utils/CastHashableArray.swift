//
//  CastHashableArray.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/16/21.
//

import Foundation
struct CastHashableArray: Hashable{
    
    var actorName: String
    var actorPic: String
    let randomInt = Int.random(in: 1..<1000)
    func hash(into hasher: inout Hasher) {
        hasher.combine(actorName+actorPic+String(randomInt))
    }
    
}
