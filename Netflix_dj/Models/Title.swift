//
//  Movie.swift
//  Netflix_dj
//
//  Created by Dhananjay on 14/08/23.
//

import Foundation

struct TrendingTitleResult: Codable{
    let results: [Title]
}

struct Title: Codable{
    let id: Int
    let media_type: String?
    let original_title: String?
    let original_name: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
