import SwiftUI
struct SearchBar: UIViewRepresentable {
    @ObservedObject var searchVM: SearchVM
    @Binding var text: String
    var placeholder: String
    

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        @ObservedObject var searchVM: SearchVM
        let debouncer = Debouncer(delay: 0.5)
        init(text: Binding<String>, searchVM: SearchVM) {
            _text = text
            self.searchVM = searchVM
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            if(searchText.count >= 3) {
                self.searchVM.isLoaded = false
                //print("search text: " + text)
                self.debouncer.run(action:{
                    self.searchVM.fetchResults(input: self.text)
                })
            }
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            searchBar.setShowsCancelButton(false, animated: true)
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            text = ""
            searchBar.setShowsCancelButton(false, animated: true)
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, searchVM: searchVM)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

//extension SearchBar: UISearchResultsUpdating {
   
    
    
//    func fetchAutoComplete(keyword: String){
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute:{
//            self.debouncer.run(action:{
//
//                let url: String = Constants.Host+"autocomplete?ticker="+keyword
//                AF.request(url, encoding:JSONEncoding.default).validate().responseJSON { response in
//                    switch response.result{
//                    case .success(let value):
//                        let json = JSON(value)
//
//                        var autocompleteArray: [[String: String]] = []
//                        for item in json.arrayValue {
//                            var tickerDict:[String:String] = [:]
//                            tickerDict["ticker"] = item["ticker"].stringValue
//                            tickerDict["name"]=item["name"].stringValue
//                            autocompleteArray.append(tickerDict)
//                        }
//                        self.Results = autocompleteArray
//                        self.showResults = false
//                        self.showResults = true
//                        debugPrint("Autocomplete data fetched!")
//
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            })
//        })
//    }
//}
