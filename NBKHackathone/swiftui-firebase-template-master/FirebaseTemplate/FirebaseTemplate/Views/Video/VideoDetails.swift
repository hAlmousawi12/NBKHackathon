//
//  VideoDetails.swift
//  FirebaseTemplate
//
//  Created by Haider Alboloushi on 25/06/2021.
//  Copyright © 2021 OMAR. All rights reserved.
//

import SwiftUI

struct VideoDetails: View {
    var video: VideoItem
    var body: some View {
        Link(destination: URL(string: video.url)!) {
            VStack {
                RemoteImage(url: video.image)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .padding()
                Text(video.title).bold().font(.title)
                Text(video.description).padding()
            }.foregroundColor(.black)
        }
    }
}

struct VideoDetails_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetails(video: VideoItem(title: "Never Gonna give you up", description: "LOL", url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ", image: "https://i.ytimg.com/vi/dQw4w9WgXcQ/hq720.jpg?sqp=-oaymwEXCNAFEJQDSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLDX3LgTmArIBIk6uvvz4y5p95MOcg"))
    }
}
