//
//  SearchResultView.swift
//  Netflix
//
//  Created by 潘一帆 on 2021/3/18.
//

import Foundation
import SwiftUI

struct SearchResultView: View {
    @ObservedObject var searchVM : SearchVM
    var body: some View {
            ScrollView {
                VStack {
                    ForEach(searchVM.searchResult) {movie in
                        NavigationLink(destination: DetailsView(DetailsVM: DetailVM(movieID: movie.movieID, isMovie: true))) {
                            SearchCard(movie: movie)
                        }
                        .padding(3)
                    }
                }
                .padding(.leading)
                .padding(.trailing)
            }
            .navigationBarTitle("Search Result")
            
            .onAppear {
                searchVM.fetchResults(input: searchVM.input)
            }
    }
    
}

struct SearchCard: View {
    var movie: Movie
    var body: some View {
        
            RemoteImage(url: movie.imgURL)
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .cornerRadius(15)
                .overlay(CardText(movie: movie))
    }
}

struct CardText: View {
    var movie: Movie
    var body: some View {
        VStack {
            HStack {
                Text((movie.isMovie ? "MOVIE(" : "TV(") + movie.year + ")")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    
                Spacer()
                (Text(Image(systemName: "star.fill")).foregroundColor(Color.red) + Text("\(String(format: "%.1f",movie.vote/2))"))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
            }
            
            Spacer()
            HStack {
                Text(movie.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                Spacer()
            }
            
        }
        .padding()
    }
    
}

