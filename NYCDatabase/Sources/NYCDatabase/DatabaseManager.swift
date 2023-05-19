//
//  DatabaseManager.swift
//  
//
//  Created by Nicky Taylor on 3/17/23.
//

import Foundation
import CoreData
import NYCNetworking

public protocol DatabaseConforming {
    func loadPersistentStores() async
    func fetchSchools() async throws -> [SchoolEntity]
    func sync(schools: [School]) async throws
}
    
public class DatabaseManager: DatabaseConforming {
    
    public init() {
        
    }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        if let url = Bundle.module.url(forResource: "Database", withExtension: "momd") {
            if let result = NSManagedObjectModel(contentsOf: url) {
                return result
            }
            
        }
        return NSManagedObjectModel()
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        return NSPersistentContainer(name: "Database", managedObjectModel: managedObjectModel)
    }()
        
    public func loadPersistentStores() async {
        await withCheckedContinuation { continuation in
            persistentContainer.loadPersistentStores { description, error in
                if let error = error {
                    print("Load Persistent Stores Error: \(error.localizedDescription)")
                }
                continuation.resume()
            }
        }
    }
    
    public func sync(schools: [School]) async throws {
        let schoolEntities = try await fetchSchools()
                
        var schoolEntityDict = [String: SchoolEntity]()
        for schoolEntity in schoolEntities {
            if let dbn = schoolEntity.dbn, dbn.count > 0 {
                schoolEntityDict[dbn] = schoolEntity
            }
        }
        
        let context = persistentContainer.viewContext
        try await context.perform {
            for school in schools where school.dbn.count > 0 {
                if let schoolEntity = schoolEntityDict[school.id] {
                    self.inject(schoolEntity: schoolEntity,
                                school: school)
                } else {
                    let schoolEntity = SchoolEntity(context: context)
                    self.inject(schoolEntity: schoolEntity,
                                school: school)
                }
            }
            try context.save()
        }
    }
    
    public func fetchSchools() async throws -> [SchoolEntity] {
        let context = persistentContainer.viewContext
        var result = [SchoolEntity]()
        try await context.perform {
            let fetchRequest = SchoolEntity.fetchRequest()
            result = try context.fetch(fetchRequest)
        }
        return result
    }
    
    private func inject(schoolEntity: SchoolEntity, school: School) {
        schoolEntity.dbn = school.dbn
        schoolEntity.schoolName = school.schoolName
        schoolEntity.website = school.website
        schoolEntity.phoneNumber = school.phoneNumber
        schoolEntity.primaryAddressLine1 = school.primaryAddressLine1
        schoolEntity.city = school.city
        schoolEntity.zip = school.zip
        schoolEntity.stateCode = school.stateCode
    }
    
}
