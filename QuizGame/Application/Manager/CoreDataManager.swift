//
//  CoreDataManager.swift
//  QuizGame
//
//  Created by Evandro Rodrigo Minamoto on 06/09/24.
//

import CoreData
import UIKit

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Person")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveUser(name: String, score: Int) {
        let context = persistentContainer.viewContext
        let userEntity = NSEntityDescription.insertNewObject(forEntityName: "UserScore", into: context)
        userEntity.setValue(name, forKey: "name")
        userEntity.setValue(score, forKey: "score")
        
        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    func fetchUserByName(name: String) -> User? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserScore> = UserScore.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let userEntity = results.first {
                return User(name: userEntity.name ?? "", score: Int(userEntity.score))
            }
        } catch {
            print("Failed to fetch user: \(error)")
        }
        return nil
    }
    
    func fetchAllUsers() -> [User] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<UserScore> = UserScore.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { User(name: $0.name ?? "", score: Int($0.score)) }
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }
    
    func fetchAllUsersSortedByScore() -> [User] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<UserScore> = UserScore.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        
        do {
            let usersScores = try context.fetch(request)
            return usersScores.map { User(name: $0.name ?? "", score: Int($0.score)) }
        } catch {
            return []
        }
    }
}

