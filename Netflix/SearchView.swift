//
//  SearchView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import Foundation
import SwiftUI

struct SearchView: View {
    let movies = ["star wars", "avengers", "alien", "interstellar", "justice league"]
    @State private var searchText : String = ""
    var body: some View {
        NavigationView {
           VStack {
                SearchBar(text: $searchText, placeholder: "Search Movies, TVs...")
                if (searchText.count >= 3) {
                    List {
                        ForEach(self.movies, id: \.self) { movie in
                            NavigationLink(destination:
                                SearchResultView(searchVM: SearchVM(input: movie))) {
                                Text(movie)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                Spacer()
            }
            .navigationBarTitle("Search")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
