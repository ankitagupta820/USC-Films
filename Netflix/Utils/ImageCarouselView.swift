//
//  ImageCarouselView.swift
//  Netflix
//
//  Created by Ankita Gupta on 19/03/21.
//

import Foundation
import Foundation
import SwiftUI
import Combine


struct ImageCarouselView<Content: View>: View {

    private var numberOfImages: Int
    private var content: Content
    private let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    @State private var currentIndex: Int = 0
    
    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
                
                    HStack(spacing: 0) {
                        self.content
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                    .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                    .animation(.spring())
                    .onReceive(self.timer) { _ in
                        self.currentIndex = (self.currentIndex + 1) % self.numberOfImages
                    }
                }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        
        GeometryReader { geometry in
                    ImageCarouselView(numberOfImages: 3) {
                        Image("img1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                        Image("img2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                        Image("img3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }.frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
    }
}
