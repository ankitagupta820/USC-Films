//
//  WatchlistView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import Foundation
import SwiftUI

struct WatchlistView: View {
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    @ObservedObject var WatchListVM : WatchListVM
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(WatchListVM.watchList) { item in
                RemoteImage(url: item.imgURL)
                    .aspectRatio(contentMode: .fit)
            }
        }
        Spacer()
        .navigationBarTitle("WatchList")
        
    }}

