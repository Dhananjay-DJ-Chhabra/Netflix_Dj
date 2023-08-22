//
//  APICaller.swift
//  Netflix_dj
//
//  Created by Dhananjay on 14/08/23.
//

import Foundation

struct Constants{
    static let api_key = "fe82be3bd60c4178129fe52ebb495ca4"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeApi_Key = "AIzaSyDPvnRlL-hWXLLKplYylIiExZb4PMlqwVk"
    static let youtubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}


class APICaller{
    static let shared = APICaller()
    
    func getTrendingMovies(completionHandler: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.api_key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResult.self, from: data)
                completionHandler(.success(results.results))
            }catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTrendingTv(completionHandler: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.api_key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResult.self, from: data)
                completionHandler(.success(results.results))
            }catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completionHandler: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.api_key)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResult.self, from: data)
                completionHandler(.success(results.results))
            }catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func getPopular(completionHandler: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.api_key)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResult.self, from: data)
                completionHandler(.success(results.results))
            }catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRated(completionHandler: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.api_key)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResult.self, from: data)
                completionHandler(.success(results.results))
            }catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completionHandler: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.api_key)&language=en-US&sort_by=popularity.desc&include_adult=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResult.self, from: data)
                completionHandler(.success(results.results))
            }catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func getSearchResults(query: String, completionHandler: @escaping (Result<[Title], Error>) -> Void){
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.api_key)&query=\(encodedQuery)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResult.self, from: data)
                completionHandler(.success(results.results))
            }catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func getYoutubeTrailer(with query: String, completionHandler: @escaping (Result<VideoElement, Error>) -> Void){
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.youtubeBaseUrl)q=\(encodedQuery)&key=\(Constants.youtubeApi_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                if !results.items.isEmpty {
                    completionHandler(.success(results.items[0]))
                }else{
                    completionHandler(.success(VideoElement(id: IDVideoElement(kind: "", videoId: ""))))
                }
            }catch{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}
