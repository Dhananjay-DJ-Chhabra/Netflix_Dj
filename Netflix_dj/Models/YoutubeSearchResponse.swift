//
//  YoutubeSearchResponse.swift
//  Netflix_dj
//
//  Created by Dhananjay on 19/08/23.
//

import Foundation


struct YoutubeSearchResponse: Codable{
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IDVideoElement
}

struct IDVideoElement: Codable{
    let kind: String
    let videoId: String
}
