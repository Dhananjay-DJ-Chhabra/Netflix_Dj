//
//  DataPersistenceManager.swift
//  Netflix_dj
//
//  Created by Dhananjay on 21/08/23.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager{
    
    static let shared = DataPersistenceManager()
    
    func downloadTitle(with model: Title, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let titleItem = TitleItem(context: context)
        
        titleItem.id = Int64(model.id)
        titleItem.media_type = model.media_type
        titleItem.original_title = model.original_title
        titleItem.original_name = model.original_name
        titleItem.poster_path = model.poster_path
        titleItem.overview = model.overview
        titleItem.vote_count = Int64(model.vote_count)
        titleItem.release_date = model.release_date
        titleItem.vote_average = model.vote_average
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(error))
        }
    }
    
    func fetchDownloadedTitles(completion: @escaping (Result<[TitleItem], Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do{
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(error))
        }
    }
    
    func deleteDownloadedTitle(with model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(error))
        }
    }
}
