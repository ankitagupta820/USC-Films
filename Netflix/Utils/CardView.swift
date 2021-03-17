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
                Text(reviewCard.reviewTitle)
                    .fontWeight(.bold)
                    .font(.headline)
                    
                Text("By "+reviewCard.reviewAuth+" on "+String(self.changeDateFormat()))
                        .padding(.bottom,1)
                        .foregroundColor(Color.gray)
                
                StarRating(rating: .constant(reviewCard.rating))
                    .padding(.bottom,2)
              
                Text(reviewCard.reviewText)
                    .font(.body)
 
            }
       
         //   .contentShape(RoundedRectangle(cornerRadius: 50))
          //  .background(Color.gray)
           
            
           
            
      
        }
  //  }
    
    func changeDateFormat() -> String{
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
        let dateArray = reviewCard.reviewDate.components(separatedBy: "/")
       // print(dateArray[1])
        var dateString = months[String("03")] ?? nil
        dateString = dateString!+" "+dateArray[2]+", "+dateArray[0]
        return dateString!
        
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
