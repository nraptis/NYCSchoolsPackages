//
//  Application.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import Foundation
import NYCNetworking
import NYCDatabase

class Application {
    
    let networkManager = NetworkManager()
    let databaseManager = DatabaseManager()
    
    lazy var schoolViewModel: SchoolViewModel = {
       SchoolViewModel(networkManager: networkManager,
                       databaseManager: databaseManager)
    }()
    
}
