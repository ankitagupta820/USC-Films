//
//  StarRating.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/14/21.
//

import SwiftUI

struct StarRating: View {
    @Binding var rating: Int
    var label=""
    var offImage:Image?
    var onImage=Image(systemName:"star.fill")
    var offColor=Color.gray
    var onColor=Color.red
    var maxRating = 5
    
    var body: some View {
        HStack{
            if(label.isEmpty==false){
                Text(label)
            }
            ForEach(1..<maxRating+1) { number in
                self.showImage(for: number)
                    .foregroundColor(number>self.rating ? self.offColor : self.onColor)
                    .padding(.trailing, -10)
            }
        }
    }
    
    func showImage(for number:Int) -> Image{
        if number>rating{
            return offImage ?? onImage
        }
        else{
            return onImage
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: .constant(4))
    }
}
