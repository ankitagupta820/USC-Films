//
//  DefaultsStorage.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/13/21.
//

import Foundation

class DefaultsStorage{

    static func reset(){
        
        //needs to be changed
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "PURCHASES_ARRAY")
        defaults.removeObject(forKey: "PURCHASES")
        defaults.removeObject(forKey: "BOOKMARKS")
        defaults.removeObject(forKey: "BOOKMARKS_ARRAY")
        defaults.set(20000, forKey: "BALANCE")
        
    }
    
    // functions on Edit button in portfolio section
    static func reorder(category: String, source: IndexSet, destination: Int){
        
        let defaults = UserDefaults.standard
        var Array: [String] = defaults.array(forKey: category) as? [String] ?? []
        
        Array.move(fromOffsets: source, toOffset: destination)
        
        defaults.set(Array, forKey: category)
        
    }
    
    static func deleteBookmark(from: IndexSet.Element){
        
        let defaults = UserDefaults.standard
        var Array: [String] = defaults.array(forKey: "BOOKMARKS_ARRAY") as? [String] ?? []
        var Bookmarks: [String: String] = defaults.dictionary(forKey: "BOOKMARKS") as? [String : String] ?? [:]
        
        
        let stock = Array.remove(at: from)
        Bookmarks.removeValue(forKey: stock)
        
        defaults.set(Array, forKey: "BOOKMARKS_ARRAY")
        defaults.set(Bookmarks, forKey: "BOOKMARKS")
        
    }
    
    //Bookmarks
    static func getBookMarkStateArray()-> [String]{
        
        let defaults = UserDefaults.standard
        let BookmarkArray: [String] = defaults.array(forKey: "BOOKMARKS_ARRAY") as? [String] ?? []
        
        return BookmarkArray
        
    }
    
    static func getBookMarks() -> [String: String]{
        
        let defaults = UserDefaults.standard
        let Bookmarks: [String: String] = defaults.dictionary(forKey: "BOOKMARKS") as? [String : String] ?? [:]
        
        return Bookmarks
    }
    
    static func isBookMarked(ticker: String)-> Bool{
        
        let defaults = UserDefaults.standard
        let Bookmarks: [String] = defaults.array(forKey: "BOOKMARKS_ARRAY") as? [String] ?? []
        
        if Bookmarks.contains(ticker){
            return true
        }else{
            return false
        }
    }
    
    static func toggleBookmark(ticker: String, name: String){
        
        let defaults = UserDefaults.standard
        var Bookmarks: [String: String] = defaults.dictionary(forKey: "BOOKMARKS") as? [String : String] ?? [:]
        var BookmarksArray: [String] = defaults.array(forKey: "BOOKMARKS_ARRAY" ) as? [String] ?? []
        
        if BookmarksArray.contains(ticker){
            Bookmarks.removeValue(forKey: ticker)
            if let index = BookmarksArray.firstIndex(of: ticker) {
                BookmarksArray.remove(at: index)
            }
        }else{
            Bookmarks[ticker]=name
            BookmarksArray.append(ticker)
        }
   
        defaults.set(Bookmarks, forKey: "BOOKMARKS")
        defaults.set(BookmarksArray, forKey: "BOOKMARKS_ARRAY")
    }
    
 
    //Balance
    static func initBalance(){
        
       // reset()
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        if !dictionary.keys.contains("BALANCE"){
            defaults.set(20000, forKey: "BALANCE")
        }
    }
    
    static func getBalance()->Float{
        
        let defaults = UserDefaults.standard
        return defaults.float(forKey: "BALANCE")
        
    }
    
    static func setBalance(value: Float){
        
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "BALANCE")
        
    }


}
