//
//  SongsView.swift
//  spotify-clone-b
//
//  Created by Mac11 on 15/06/24.
//

import SwiftUI

struct SongsView: View {
    
    @StateObject var songViewModel = SongViewModel()
    
    var body: some View {
        ZStack {
            Color("dark")
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Lista de canciones")
                    .font(.title3)
                    .foregroundStyle(.white)
                
                
                ScrollView {
                    ForEach(songViewModel.songs, id: \.id) {
                        song in
                        HStack {
                            AsyncImage(url: URL(string: song.image)) { image in image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(song.title)
                                    .foregroundStyle(.white)
                                    .font(.body)
                                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                Text(song.description)
                                    .foregroundStyle(.white)
                                    .font(.caption2)
                                    .lineLimit(1)
                                    .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                                Button(action: {
                                    songViewModel.playSong(url: song.mp3)
                                    
                                    if songViewModel.isPlay{
                                        songViewModel.audioPlayer?.play()
                                    } else {
                                        songViewModel.audioPlayer?.pause()
                                    }
                                    songViewModel.isPlay.toggle()
                                }, label: {
                                    Image(systemName: songViewModel.isPlay ? "play.circle" : "pause.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.caption2)
                                        
                                }).contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                        }.padding(.bottom)
                    }.task {
                        await songViewModel.makeHTTPRequest()
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    SongsView()
}
