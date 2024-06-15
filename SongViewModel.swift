//
//  SongViewModel.swift
//  spotify-clone-b
//
//  Created by Mac11 on 15/06/24.
//

import Foundation


class SongViewModel: ObservableObject {
    
    @Published var songs: [Song] = [Song]()
    
    func makeHTTPRequest() async {
        guard let url = URL(string: "https://spotify-api-lac-kappa.vercel.app/api/songs") else {
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    return
                }
            }
            
            if let decoder = try? JSONDecoder().decode([Song].self, from: data){
                self.songs = decoder
            } else {
                print("Hubo un error en el decoder")
            }
            
        } catch let error {
            print("Error", error.localizedDescription)
        }
    }
    
}
