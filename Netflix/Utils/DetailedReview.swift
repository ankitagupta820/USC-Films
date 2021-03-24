//
//  DetailedReview.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/21/21.
//

import SwiftUI

struct DetailedReview: View {
    let reviewCard: ReviewCard
    let movieName: String
    var body: some View {
       
           
       
            ScrollView{
                //LazyVStack{
                    VStack (alignment: .leading){
                        Text(movieName)
                            .font(.system(size: 25.0, design:.rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                            .padding(.bottom,5)
                        Text("By "+reviewCard.reviewAuth + " on "+String(self.changeDateFormat()))
                            .padding(.bottom,1)
                            .foregroundColor(Color.gray)
                        
                        (Text(Image(systemName: "star.fill")).foregroundColor(Color.red) + Text("\(String(format: "%.1f",(reviewCard.rating/2)))/5.0"))
                            .padding(.bottom,1)
                        Text(reviewCard.reviewText)
                            .font(.body)
                           
                    }
           
            }
          
        
        
       
    }
    
    func changeDateFormat() -> String{
        //TODO: Change as per "2016-04-29T18:08:41.892Z
        let months: [String:String] = [
            "01": "Jan",
            "02": "Feb",
            "03": "Mar",
            "04": "Apr",
            "05": "May",
            "06":"Jun",
            "07": "Jul",
            "08": "Aug",
            "09": "Sep",
            "10": "Oct",
            "11": "Nov",
            "12": "Dec"
        ]
        let dateArray = reviewCard.reviewDate.components(separatedBy: "T")
       // print(dateArray[1])
        let dArray=dateArray[0].components(separatedBy: "-")
        
        guard var month = months[dArray[1]] else { return "Jan" }
        let year = dArray[0]
        let date=dArray[2]
    
        let dateString = month+" "+date+", "+year//dateString!+" "+dateArray[2]+", "+dateArray[0]
        return dateString
        
    }
}

//struct DetailedReview_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedReview()
//    }
//}
