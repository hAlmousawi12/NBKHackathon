//
//  Video.swift
//  FirebaseTemplate
//
//  Created by Haider Alboloushi on 25/06/2021.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct VideoItem: Codable, Hashable {
    var title: String
    var description: String
    var url: String
    var image: String
}

struct Video: View {
    @EnvironmentObject var itemsEnv: VideoEnv
    var body: some View {
        List(itemsEnv.items, id: \.self) { item in
            NavigationLink(destination: VideoDetails(video: item)) {
                VStack(alignment: .leading) {
                    RemoteImage(url: item.image)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .cornerRadius(20)
                    Text(item.title)
                }
            }
        }.navigationBarHidden(true)
        .onAppear(perform: itemsEnv.loadItems)
    }
}

struct Video_Previews: PreviewProvider {
    static var previews: some View {
        Video()
            .environmentObject(VideoEnv())
    }
}

struct Title: View {
    let titleText: String
    var body: some View {
        HStack {
            VStack {
                Text(titleText).bold()
            }
            Spacer()
        }
    }
}

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 150)
            .cornerRadius(10)
    }
}
