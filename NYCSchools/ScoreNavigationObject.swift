//
//  ScoreNavigationObject.swift
//  NYCSchools
//
//  Created by Nicky Taylor on 3/17/23.
//

import Foundation
import NYCNetworking

struct ScoreNavigationObject {
    let school: SchoolModel
    let score: Score
}

extension ScoreNavigationObject: Hashable {
    static func == (lhs: ScoreNavigationObject, rhs: ScoreNavigationObject) -> Bool {
        lhs.school.dbn == rhs.school.dbn
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(school.dbn)
    }
}

