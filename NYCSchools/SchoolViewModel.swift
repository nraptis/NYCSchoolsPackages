//
//  SchoolViewModel.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import Foundation
import SwiftUI
import NYCNetworking
import NYCDatabase

class SchoolViewModel: ObservableObject {
    
    public static var preview: SchoolViewModel {
        let application = Application()
        return application.schoolViewModel
    }
    
    @Published var testScoreError = false
    @Published var schools = [SchoolModel]()
    @Published var navigationPath = NavigationPath()
    
    let networkManager: NetworkConforming
    let databaseManager: DatabaseConforming
    
    init(networkManager: NetworkConforming, databaseManager: DatabaseConforming) {
        
        self.networkManager = networkManager
        self.databaseManager = databaseManager
        
        Task {
            await databaseManager.loadPersistentStores()
            await fetchSchools()
        }
    }
    
    func fetchSchools() async {
        
        var schools = [School]()
        do {
            let _schools = try await networkManager.fetchSchools()
            schools = _schools
        } catch let error {
            print("could not fetch schools, network error: \(error.localizedDescription)")
        }
        
        if schools.count > 0 {
            do {
                try await databaseManager.sync(schools: schools)
            } catch let error {
                print("could not fetch schools, database sync error: \(error.localizedDescription)")
            }
        }
        
        var _schoolEntities = [SchoolEntity]()
        do {
            _schoolEntities = try await databaseManager.fetchSchools()
        } catch let error {
            print("could not fetch schools, database fetch error: \(error.localizedDescription)")
        }
        
        let schoolEntities = _schoolEntities
        await MainActor.run {
            self.schools = schoolEntities.map {
                SchoolModel(schoolEntity: $0)
            }
        }
    }
    
    enum ScoreError: Error {
        case empty
    }
    func clickSchoolCell(for school: SchoolModel) {
        
        Task {
            
            do {
                let scores = try await networkManager.fetchScores(dbn: school.dbn)
                guard let score = scores.first else {
                    throw ScoreError.empty
                }
                
                let scoreNavigationObject = ScoreNavigationObject(school: school,
                                                                  score: score)
                await MainActor.run {
                    navigationPath.append(scoreNavigationObject)
                }
            } catch {
                await MainActor.run {
                    self.testScoreError = true
                }
            }
        }
    }
    
    func schoolName(for school: SchoolModel) -> String {
        return school.schoolName ?? ""
    }
    
    func schoolPhoneNumber(for school: SchoolModel) -> String {
        return school.phoneNumber ?? ""
    }
    
    func schoolAddressLine1(for school: SchoolModel) -> String {
        return school.primaryAddressLine1 ?? ""
    }
    
    func schoolAddressLine2(for school: SchoolModel) -> String {
        if let city = school.city, let state = school.stateCode, let zip = school.zip {
            return "\(city), \(state), \(zip)"
        }
        return ""
    }
    
    func schoolWebsite(for school: SchoolModel) -> String {
        if let website = school.website {
            return "https://\(website)"
        }
        return ""
    }
    
    func scoreTestTakerCount(for score: Score) -> String {
        return score.numOfSatTestTakers ?? ""
    }
    
    func scoreMath(for score: Score) -> String {
        return score.satMathAvgScore ?? ""
    }
    
    func scoreCriticalReading(for score: Score) -> String {
        return score.satCriticalReadingAvgScore ?? ""
    }
    
    func scoreWriting(for score: Score) -> String {
        return score.satWritingAvgScore ?? ""
    }
    
}
