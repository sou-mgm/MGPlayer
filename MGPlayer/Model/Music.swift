//
//  File.swift
//  MusicBeat
//
//  Created by Matheus Matias on 08/11/22.
//

import UIKit


class Music{
    var name: String
    var image: String
    var artist: String
    var genre: String
    var file: String
    
    init(name: String, image: String, artist: String, genre: String, file: String) {
        self.name = name
        self.image = image
        self.artist = artist
        self.genre = genre
        self.file = file
    }
}

// Extensao para facilitar a add de musicas ao app
extension Music {
    
    static func getMusic() -> [Music] {
        
        let music1 = Music(name: "All Your Fault", image: "all-your-fault", artist: "Yugyeom", genre: "K-Pop", file: "all-your-fault")
        let music2 = Music(name: "After Midnight", image: "after-midnight", artist: "Astro", genre: "K-Pop", file: "after-midnight")
        let music3 = Music(name: "Alone (ft.Lee Hi)", image: "alone", artist: "Coogie", genre: "K-Pop", file: "alone")
        let music4 = Music(name: "Am I Wrong", image: "am-i-wrong", artist: "Nico & Vinz", genre: "Pop", file: "am-i-wrong")
        let music5 = Music(name: "Amnesia", image: "amnesia", artist: "Justin Timberlake", genre: "Pop", file: "amnesia")
        let music6 = Music(name: "Loco Contigo", image: "loco-contigo", artist: "Dj Snake/J Bavin/Tyga", genre: "Latino", file: "loco-contigo")
        let music7 = Music(name: "Recem Abandonado", image: "recem-abandonado", artist: "Wesley Safadão", genre: "Sertanejo", file: "recem-abandonado")

        return [music1,music2,music3,music4,music5,music6,music7]
    }
    
}
