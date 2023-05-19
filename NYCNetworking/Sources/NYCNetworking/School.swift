//
//  School.swift
//  NYCNetworking
//
//  Created by Nicky Taylor on 3/17/23.
//

import Foundation

public struct School: Decodable {
    public let dbn: String
    public let schoolName: String?
    
    public let website: String?
    public let phoneNumber: String?
    
    public let primaryAddressLine1: String?
    public let city: String?
    public let zip: String?
    public let stateCode: String?
}

extension School: Identifiable {
    public var id: String { dbn }
}

extension School: Hashable {
    
    public static func == (lhs: School, rhs: School) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension School {
    public static var preview: School {
        School(dbn: "02M260",
               schoolName: "Clinton School Writers & Artists, M.S. 260",
               website: "www.theclintonschool.net",
               phoneNumber: "212-524-4360",
               primaryAddressLine1: "10 East 15th Street",
               city: "Manhattan",
               zip: "10003",
               stateCode: "NY")
    }
}
