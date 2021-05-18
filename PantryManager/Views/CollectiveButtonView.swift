//
//  CollectiveButtonView.swift
//  PantryManager
//
//  Created by Davide Andreoli on 18/05/21.
//

import SwiftUI

struct CollectiveButtonView: View {
    //State variable
    @State var imageName: String
    @State var count: Int
    @State var title: String
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Image(systemName: imageName)
                    .background(
                        Circle()
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .scaledToFill()
                            .padding(-4)
                    )
                    .foregroundColor(.white)
                    .scaleEffect(0.8)
                    .padding(.bottom, 5)
                Spacer()
                Text("\(count)")
                    .font(.headline)
            }
            HStack {
                Text(title)
                    .font(.subheadline)
            }
        }
        .padding(10)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct CollectiveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CollectiveButtonView(imageName: "tray.2", count: 3, title: "Title")
    }
}
