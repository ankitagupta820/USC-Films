//
//  SearchView.swift
//  Netflix
//
//  Created by Ankita Gupta on 12/03/21.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State private var searchText : String = ""
    @ObservedObject var searchVM : SearchVM = SearchVM()
    var body: some View {
        NavigationView {
           VStack {
                SearchBar(searchVM: self.searchVM, text: $searchText, placeholder: "Search Movies, TVs...")
            if (searchVM.searchResult.count > 0 && searchText.count >= 3 && searchVM.isLoaded) {
                    SearchResultView(searchVM: self.searchVM, searchText: self.$searchText)
                }
            if (searchText.count >= 3 && searchVM.searchResult.count == 0 && searchVM.isLoaded){
                    VStack {
                        Text("No Results")
                            .font(.system(size: 32))
                    }
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
