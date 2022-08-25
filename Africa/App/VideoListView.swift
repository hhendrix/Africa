//
//  VideoListView.swift
//  Africa
//
//  Created by Harry Lopez on 7/04/22.
//

import SwiftUI

struct VideoListView: View {
    //MARK: PROPERTIES
    @State var videos: [Video] = Bundle.main.decode("videos.json")
     
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    //MARK: BODY
    
    var body: some View {
        NavigationView {
            List{
                ForEach(videos) { video in
                    NavigationLink(destination: VideoPlayerView(videoSelected: video.id, videoTitle: video.name)) {
                        VideoListItemView(video: video)
                            .padding(.vertical, 8)
                    }
                }// LOOP
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Videos", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        //Shuffle Videos
                        videos.shuffle()
                        hapticImpact.impactOccurred()
                    }){
                        Image(systemName: "arrow.2.squarepath")
                    }
                }
            }
            
        }// NAVIGATION
    }
}
//MARK: PREVIEW
struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}
