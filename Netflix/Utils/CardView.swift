//
//  CardView.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/15/21.
//

import SwiftUI

struct CardView: View {
    let reviewCard: ReviewCard
    let formatterStringDate = DateFormatter()
   
    
    var body: some View {

      
                VStack(alignment: .leading) {
                    Text("A review by "+reviewCard.reviewAuth)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .padding(.bottom,1)
                    Text("Written by "+reviewCard.reviewAuth+" on "+String(self.changeDateFormat()))
                            .padding(.bottom,1)
                            .foregroundColor(Color.gray)
                    
                    (Text(Image(systemName: "star.fill")).foregroundColor(Color.red) + Text("\(String(format: "%.1f",(reviewCard.rating/2)))/5.0"))
                        .padding(.bottom,1)
//
//                    HTMLView(htmlString: reviewCard.reviewText)
//                        .font(.system(size: 25.0, design:.rounded))
//                        .foregroundColor(Color.black)
//                        .lineLimit(3)
                    Text(reviewCard.reviewText)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .lineLimit(3)
     
                }
           
      
    }
  //  }
    
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
struct ExDivider: View {
    let color: Color = .gray
    let width: CGFloat = 0.5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
           // .edgesIgnoringSafeArea(.horizontal)
           
    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(ReviewCard: ReviewCard.example)
//    }
//}
