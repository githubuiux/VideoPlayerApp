//
//  ContentView.swift
//  VideoPlayerApp
//
//  Created by Levent on 4.06.2023.
//

import SwiftUI
import AVKit
import AVFoundation

struct ContentView: View {
    @State private var currentVideoIndex: Int
    @State private var player: AVPlayer
    @State private var playerList: [AVPlayer] = []
    
    let videoURLs = [
        // bu linkler gösterilecek videoların bulundugu linklerin adresleri
        URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
        URL(string: "https://freetestdata.com/wp-content/uploads/2022/02/Free_Test_Data_7MB_MP4.mp4")!,
        URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!
    ]
    
    init() {
        
        // init, baslatici olarak hazırlanan taslaklardir.
        currentVideoIndex = 0
        player = AVPlayer(url: videoURLs[0])
        playerList.append(AVPlayer(url: videoURLs[0]))
        playerList.append(AVPlayer(url: videoURLs[1]))
        playerList.append(AVPlayer(url: videoURLs[2]))
    }
    
    func setupPlayer(index: Int) {
        player = playerList[index]
        player.volume = 20
    }
    
    var body: some View {
        VideoPlayer(player: player){
            VStack{
                Spacer()
                Spacer()
                Spacer()
                HStack(spacing: 20){
                    Image(uiImage: UIImage(named: "profile")!)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                    Text("@VideoWatchLikeYouTube")
                        .foregroundColor(.white)
                        .font(.custom("AmericanTypewriter", fixedSize: 12))
                    
                    Button("Subscribe") {
                        
                    }.padding(.all, 5)
                        .background(Color.white)
                        .cornerRadius(20)
                        .foregroundColor(.black)
                        .tint(.white)
                }
                .padding(.bottom, 10)
                Text("A Composition of different sample videos shown as a test videos #Video # Testign")
                    .foregroundColor(.white)
                    .font(.custom("AmericanTypewriter", fixedSize: 15))
                    .padding(.bottom, 10)

                HStack {
                    Image(systemName: "music.note")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                    Text("Orignial sound")
                        .foregroundColor(.white)
                        .font(.custom("AmericanTypewriter", fixedSize: 10))
                    Spacer()
                }
                .padding(.bottom, 100)
            }
            .padding()
            
        }.gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded { gesture in
                player.volume = 0.0
                if gesture.translation.width < 0 {
                    // sola kaydirip siradaki videoyu oynat
                    currentVideoIndex = (currentVideoIndex+1)%videoURLs.count
                } else if gesture.translation.width > 0 {
                    // saga kaydirip bir onceki videoyu oynat
                    currentVideoIndex = (currentVideoIndex-1 + videoURLs.count) % videoURLs.count
                }
                setupPlayer(index: currentVideoIndex)
            })
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            playerList.append(AVPlayer(url: videoURLs[0]))
            playerList.append(AVPlayer(url: videoURLs[1]))
            playerList.append(AVPlayer(url: videoURLs[2]))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
