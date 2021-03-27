//
//  DropViewDelegate.swift
//  Netflix
//
//  Created by 潘一帆 on 2021/3/19.
//

import Foundation
import SwiftUI

struct DropViewDelegate: DropDelegate {
    var item: MovieTV
    var watchListVM: WatchListVM
    
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    
    func dropEntered(info: DropInfo) {
        let fromIndex = watchListVM.watchList.firstIndex {(item) -> Bool in
            return item.title == watchListVM.currentMovieTV?.title
        } ?? 0
        
        let toIndex = watchListVM.watchList.firstIndex {(item) -> Bool in
            return item.title == self.item.title
        } ?? 0
        
        if fromIndex != toIndex {
            let fromItem = watchListVM.watchList[fromIndex]
            watchListVM.watchList[fromIndex] = watchListVM.watchList[toIndex]
            watchListVM.watchList[toIndex] = fromItem
            DefaultsStorage.swap(from: fromIndex, to: toIndex)
        }
    }
}
