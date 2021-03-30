//
//  LongText.swift
//  Netflix
//
//  Created by Rucha Tambe on 3/20/21.
//

import SwiftUI
//for expandable card
struct LongText: View {

    /* Indicates whether the user want to see all the text or not. */
    @State private var expanded: Bool = false

    /* Indicates whether the text has been truncated in its display. */
    @State private var truncated: Bool = false

    private var text: String

    init(_ text: String) {
        self.text = text
    }

    private func determineTruncation(_ geometry: GeometryProxy) {
        // Calculate the bounding box we'd need to render the
        // text given the width from the GeometryReader.
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(self.text)
                .font(.system(size: 15))
                .lineLimit(self.expanded ? nil : 3)
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.determineTruncation(geometry)
                    }
                })

            if self.truncated {
                HStack{
                    Spacer()
                    self.toggleButton
                }
                
            }
        }
    }

    var toggleButton: some View {
        Button(action: { self.expanded.toggle() }) {
            Text(self.expanded ? "Show less" : "Show more..")
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
               
        }
    }

}

